Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E488D708358
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjERN65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjERN6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:58:55 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD3110D5
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:58:53 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 7CE4523E25;
        Thu, 18 May 2023 09:58:51 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pze9b-cDb-00; Thu, 18 May 2023 15:58:51 +0200
Date:   Thu, 18 May 2023 15:58:51 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Tom Rix <trix@redhat.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: emu10k1: set variables emu1010_routing_info and
 emu1010_pads_info storage-class-specifier to static
Message-ID: <ZGYvG2Sf9ZeeOmL6@ugly>
Mail-Followup-To: Tom Rix <trix@redhat.com>, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230518123826.925752-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230518123826.925752-1-trix@redhat.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 08:38:26AM -0400, Tom Rix wrote:
>smatch reports
  ^^^^^^ is this the best word to use here?

>sound/pci/emu10k1/emumixer.c:519:39: warning: symbol
>  'emu1010_routing_info' was not declared. Should it be static?
>sound/pci/emu10k1/emumixer.c:859:36: warning: symbol
>  'emu1010_pads_info' was not declared. Should it be static?
>
>These variables are only used in their defining file, so it should be static
							  ^^ they
>
>Signed-off-by: Tom Rix <trix@redhat.com>
>
Reviewed-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

(also amending one of the still pending patches. thanks!)

regards
