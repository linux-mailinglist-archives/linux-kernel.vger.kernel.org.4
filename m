Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E24360223C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiJRDLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiJRDJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:09:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1C5900E3;
        Mon, 17 Oct 2022 20:07:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BBF961372;
        Tue, 18 Oct 2022 03:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45804C433C1;
        Tue, 18 Oct 2022 03:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062441;
        bh=eZhhl7tOp1Cb4YAFlsgrbaKnvt3uneY/IvYQR4QrT2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goKrt158gc/JiA3h19WUFCkVMGA5Qapuar3flCjmprpRsNas5MJp88fX8LOQnD7/s
         hKpjUzwgSFDRSVjD0IkIzZH6AKfIVESqTMZj0+FW/VVjBLW0wxXY5XOI8i6KAv4oob
         RfKQrl3Xqm9J14RI/8ppl5kczGRpQjp+aGr9eOWCxLytBjBk/mO17N3m8QPgqrYpdq
         14zyXxskjp5To1TRyEOVkMpaeeCyT+Evhub/LmTBcSbNQL5vKJ2jrUtOiVVoYF816u
         lz77exJFPtPHR+AqPaqUbEI/m0KCXVzZAHAp75R+t42Zmb9TM0cvTdd5Q7sPfkdwDU
         Dw03BXy6da79Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] ARM: dts: qcom: fix node name for rpm-msg-ram
Date:   Mon, 17 Oct 2022 22:05:53 -0500
Message-Id: <166606235857.3553294.5287082408793273005.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220924145126.24978-1-luca@z3ntu.xyz>
References: <20220924145126.24978-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022 16:51:25 +0200, Luca Weiss wrote:
> Adjust the name to match the bindings and fix the following validation
> error:
> 
> <snip>/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dtb: memory@fc428000: $nodename:0: 'memory@fc428000' does not match '^sram(@.*)?'
>         From schema: <snip>/Documentation/devicetree/bindings/sram/sram.yaml
> 
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: qcom: fix node name for rpm-msg-ram
      commit: 7475f7248ebaf1cd29d6cb21b4523bfcc30eb332

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
