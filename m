Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917F465851D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiL1RJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiL1RJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:09:29 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C20E2AB;
        Wed, 28 Dec 2022 09:09:24 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 692E059654580; Wed, 28 Dec 2022 18:09:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 55C14621FDF9D;
        Wed, 28 Dec 2022 18:09:21 +0100 (CET)
Date:   Wed, 28 Dec 2022 18:09:21 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     oss-security@lists.openwall.com
cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
In-Reply-To: <Y6xzIR9P+a6uaaEx@itl-email>
Message-ID: <99n882p8-41oq-9763-314-24r434o4549o@vanv.qr>
References: <Y6SJDbKBk471KE4k@p183> <Y6TUJcr/IHrsTE0W@codewreck.org> <1a1963aa1036ba07@orthanc.ca> <20221228152458.6xyksrxunukjrtzx@mutt-hbsd> <Y6xzIR9P+a6uaaEx@itl-email>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday 2022-12-28 17:47, Demi Marie Obenour wrote:
>> Examples:
>> 
>> 1. /proc/pid/stats.json
>> 2. /proc/pid/stats.xml
>> 3. /proc/pid/stats.yaml_shouldnt_be_a_thing
>
>A binary format would be even better.  No risk of ambiguity.

So like EBML?
