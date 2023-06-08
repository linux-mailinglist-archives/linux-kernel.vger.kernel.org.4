Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72504727923
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjFHHsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjFHHrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:47:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443D32126
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:47:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so303860f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686210450; x=1688802450;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKpO5ItYiMJJEW+sejs/pUx6xuufVOGsXiL4H+U2QwY=;
        b=VRapvNbs5TXGVO1BxVueVxAZD0DTuxkR7z+FFcdZQ/M4+d2mDQcPgQBG+rk4w3CiMJ
         n5DGxnLn5UYVzwS3kqnNYZW2EBiaZDLyrrqZ2kKur2Gq/TlX4T2S1//Gcm+r6hZjL8R9
         LOaDcZUftcq+xcSn43bZt4NN+oFznjt1EMPIXdu/iFo4un+jotj1GY61o0h94paoobTk
         K3GyC8q03HLXlkXk4UzzjmzF54ihv6AoE9mZo0pdUSp2u/7ej6V9rULUnkQsNesmSpc8
         q86ux17YDjsKVl7KnD4SwxIvalG699Pl2hib4Oi+a5KOBKEdkIReMu5+Cqbltq9TSt/v
         1q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686210450; x=1688802450;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pKpO5ItYiMJJEW+sejs/pUx6xuufVOGsXiL4H+U2QwY=;
        b=H47/X4DBABqdL9cOy5Tun0pgaHmvSrTlEEmwJOIvAzgHpgNKJ1gAWTLLAEdhbchFrp
         V7wmEatmbgX3RGwnkZy9DzcOlBXxf2NfRXCOk6VMHqO3ngLzQ9wKSv7ymboBDAGCucht
         O4A7efMPtZXMiSRa2D2B8PsiPzaO2dMdWeiC8c8UxNhXp1WR8hDC/KZ86ixz+kOJuITs
         Cs5HnjXUCy7VVLs2K6OisvUAvt4wi/b66ss0idX6nAzIwnE/OfZpsDT/q74Jo9fm8nR8
         87aTjivRCdmEcq3a1fo2YwGfAtPcRE/kM+x4LxTBT8QCarkIsV4GqctU/ITfYrqmGQ7T
         rD1g==
X-Gm-Message-State: AC+VfDyowDYFGLHLcJ/kziHoi+S/mCBI0+55jkDX2xW0qWmOPWVvq3JV
        KTqNhu3Z+3MkQ0rc02MIPjyrMBPh34Q=
X-Google-Smtp-Source: ACHHUZ7FLCvn48wU8ttK/wqkrjcYnTcAakUdl/pruduaGLnlji9N1PUvK/8kk/UjPBh0vzwGCI0Ciw==
X-Received: by 2002:a05:6000:4f:b0:306:41d3:fcb9 with SMTP id k15-20020a056000004f00b0030641d3fcb9mr6440745wrx.27.1686210449445;
        Thu, 08 Jun 2023 00:47:29 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id x4-20020a05600c21c400b003f72d7dc66esm1082613wmj.13.2023.06.08.00.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 00:47:28 -0700 (PDT)
Message-ID: <f0265d75-d0e9-9f03-c730-dcc32fcccc69@gmail.com>
Date:   Thu, 8 Jun 2023 08:47:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Qing Zhang <zhangqing@loongson.cn>, loongarch@lists.linux.dev
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: LoongArch: Add hardware breakpoints/watchpoints support
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis with cppcheck has found an issue in 
arch/loongarch/kernel/hw_breakpoint.c function hw_breakpoint_arch_parse 
with the following commit:

commit edffa33c7bb5a73e90c754c7a497162b77d7c55f
Author: Qing Zhang <zhangqing@loongson.cn>
Date:   Sat Feb 25 15:52:57 2023 +0800

     LoongArch: Add hardware breakpoints/watchpoints support


/*
  * Validate the arch-specific HW Breakpoint register settings.
  */
int hw_breakpoint_arch_parse(struct perf_event *bp,
                              const struct perf_event_attr *attr,
                              struct arch_hw_breakpoint *hw)
{
         int ret;
         u64 alignment_mask, offset;

^^ alignment mask is not initialized

         /* Build the arch_hw_breakpoint. */
         ret = arch_build_bp_info(bp, attr, hw);
         if (ret)
                 return ret;

         if (hw->ctrl.type != LOONGARCH_BREAKPOINT_EXECUTE)
                 alignment_mask = 0x7;
^^ only on this if path is alignment_mask being assigned

         offset = hw->address & alignment_mask;
         hw->address &= ~alignment_mask;

^^ offset and hw->address being modified by potentially uninitialized 
alignment_mask

         hw->ctrl.len <<= offset;

         return 0;
}


Regards,

Colin



