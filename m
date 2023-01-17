Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5609066E2D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjAQPxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjAQPw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:52:28 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4D2C22A08;
        Tue, 17 Jan 2023 07:52:13 -0800 (PST)
Date:   Tue, 17 Jan 2023 16:52:10 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Alok Tiwari <alok.a.tiwari@oracle.com>
Cc:     linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: Re: [PATCH v2 6.1] netfilter: Null pointer dereference in
 nf_tables_updobj
Message-ID: <Y8bEKooxegoRSbkO@salvia>
References: <20230117154548.3403346-1-alok.a.tiwari@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230117154548.3403346-1-alok.a.tiwari@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 07:45:49AM -0800, Alok Tiwari wrote:
> static analyzer detect null pointer dereference case for 'type'
> function __nft_obj_type_get() can return NULL value which require to handle
> if type is NULL pointer return -ENOENT

Applied, thanks.

I have appended:

This should not ever happen, because if an object is found, then that
implies there is an object type, but let's add this as a failsafe check.
