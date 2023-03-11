Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658A36B58AF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCKFji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCKFj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:39:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1101810B1D8;
        Fri, 10 Mar 2023 21:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=4yLsCbZ+rsVcEJ1kmXrEle1JKJ7I0OS935OyKpL9AKM=; b=xcGIf3w8JiMTl0Z10uD3+V0xoe
        Odws0iVWQAemxVGbjHglcDCygmRiG3Cs1ZWO9+0ja5hKD5tO1aaPVcNGfR/5umCvwuO2S9byGj6PJ
        FjH3bspaptCripA50iranAMHRqEHk+q+p7lyCyobfOCwrYQ3uJ9bmwO2dnfebTb33D0o4PD8IXwGu
        ngfS163OrHdNKxEPxyFlcgNyTXPW1Z1UJQWjPjgf0xOtCEMT0rktQrcXgks0BJVdWSGu6mIXCuZNq
        3Azq3FoMaJecXeHh8AlIOdCD14TN1wQiwMGHh9li+G4LyaVSB25OAG2aGsuCP4n1+SruB35/5+Vgl
        D4zqeyPg==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1parwr-00HDnf-AI; Sat, 11 Mar 2023 05:39:17 +0000
Message-ID: <bae2702e-3570-f461-b86f-e56ce82a636e@infradead.org>
Date:   Fri, 10 Mar 2023 21:39:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RESEND PATCH] kconfig: Proposed language extension for multiple
 builds
Content-Language: en-US
To:     Simon Glass <sjg@chromium.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     U-Boot Custodians <u-boot-custodians@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        barebox@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org
References: <20230310183717.RESEND.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230310183717.RESEND.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/10/23 18:37, Simon Glass wrote:
> (I am sending this again to get more feedback)
> 
> In the case of Linux, only one build is produced so there is only a
> single configuration. For other projects, such as U-Boot and Zephyr, the
> same code is used to produce multiple builds, each with related (but
> different) options enabled.
> 
> This can be handled with the existing kconfig language, but it is quite
> verbose, somewhat tedious and very error-prone, since there is a lot of
> duplication. The result is hard to maintain.
> 
> Describe an extension to the Kconfig language to support easier handling
> of this use case.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

IMO Masahiro has already answered this multiple times and I agree with his answers.

For others, the full previous thread is at
  https://lore.kernel.org/all/20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid/


> ---
> 
>  Documentation/kbuild/kconfig-language.rst | 134 ++++++++++++++++++++++
>  1 file changed, 134 insertions(+)


-- 
~Randy
