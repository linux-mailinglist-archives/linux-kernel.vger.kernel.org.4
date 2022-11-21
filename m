Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DBA632A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiKUQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKUQw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:52:58 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE15391FA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SG3IFde9v1FXNN+qmS3U7oUZxUIMsSHLQSifYyRuHrQ=; b=mN9orELHv4UA+leiwa61sWFj0+
        Gn03eFMm5CVLyKXDD2Vw0bYFQ13/oZlW71pSVGkGSX50AiFwXn1luRlZJdgPZsXg9AiKojOitqY3c
        A4yKoOKrrYVnRWcVmtztDxnJScsxjp6fZ57l7yuabYSOLpR/heCBzdOnQ18wcDGxvVcUuU9ed7d6G
        BTRk5heye/2ZZGp4eWdMdmF1AxowbezirKPGDmvrL8dKblpQtbTsLsCrGkcoLRI+8+Z5QNPMjTB0U
        kdZZOmaJ5WHBLnZ9/4ArQ327XZbHymNyXJzFCITkiZ5upXXKw5iy9d02WfxBVJgtnoJwkW4cWlv1y
        wHIbVdfw==;
Received: from [2a01:799:95e:1700:6395:ccbd:d000:d42b] (port=64270)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oxA2N-00079a-6C; Mon, 21 Nov 2022 17:52:51 +0100
Message-ID: <72e873e9-d4df-895b-2531-30168b8a4d64@tronnes.org>
Date:   Mon, 21 Nov 2022 17:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: git send-email friendly smtp provider anyone?
To:     Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <1bc45775-0667-01f8-36e1-9f65d3081092@tronnes.org>
 <9-qCHLoI7vMtVX2UmZbrcDSyMIJRqoWx6G2sZEn08RP15vYjPwng_fInDkKYPvllUddwXshfYs_fIpPH3_TeFLat2MQx_LT5Hfb0dxb1vGA=@emersion.fr>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <9-qCHLoI7vMtVX2UmZbrcDSyMIJRqoWx6G2sZEn08RP15vYjPwng_fInDkKYPvllUddwXshfYs_fIpPH3_TeFLat2MQx_LT5Hfb0dxb1vGA=@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 21.11.2022 14.33, skrev Simon Ser:
> I think you can apply for a linux.dev mailbox [1].
> 

Yeah you're right, I didn't know about that possibility.
But it depends on whether or not I can just use their smtp server and
keep my current email address. This looks like what's the problem with
my current ISP, I need to use the email account I have in their email
service (that I've never used) for sending through their smtp server,
but I want to send From: another email address.

Noralf.

> [1]: https://korg.docs.kernel.org/linuxdev.html
