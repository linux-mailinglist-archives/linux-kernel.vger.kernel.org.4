Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1C7302C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245711AbjFNPGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244961AbjFNPGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:06:02 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D046E43
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:06:01 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666669bb882so556994b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1686755160; x=1689347160;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+ba+k+Uik7gkIXtpKVTlI2mwc1CHEshQrw4/m8gjUQ=;
        b=JirB+nvqJpGztfu59P4yoXYKW3FcejMQW/rC1p2oKGVSvC3r/o6LDjwNmjLA/KShGy
         h2+SDcFS6ZnHmYxH1qggfkSc0p9CpxcOWKySYU1uPZT8JOWwmCYK44MOD17vXtgSVKsN
         BFgFA4Ki6XBiTwqt+q2WNlGQM2FBuMYJr65sX1grNl/PSs81pjG2FyaFDi6gSUA5gi0n
         57qHDRgyoHWIwW04xFObw4a61CaRSZfWZPPy5ikwZpEbbrxAFqK8Afk2bpNCKWRA/L+C
         LHJgrWVuB+mELZLywTY/wm2CnBm5O2HXARr9b2a6xeqzkNSBsca0lESA4Uhf3iONuT6g
         M2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686755160; x=1689347160;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+ba+k+Uik7gkIXtpKVTlI2mwc1CHEshQrw4/m8gjUQ=;
        b=JBeoHZDeA69sfMuw5kb4cvEUI0r4HzaG1ZzQtzLaI5mfgszsp3vyvdc5R+yM4eT4I4
         CdQzT+vNinbbAQdM2G1+GBP3/E/fhvb5/xS8PWcRHQSduL6y3rtFbSLfDGMpfmHpeRKO
         T49ZfFLJc8qpP2jQ022IJPh1YQka7W/Iu5OPWhuadwSO7zUSThXC6VjI8swsy2o2wvDT
         9Ye87wV/JBefLUQQev6X2cgl2EaI6fpsqWYgJbvbZAlHE7P/H9qlf2CSLxG7im8ow+Lc
         JtvNc561N8Kg1f8Mch7B101E96ko/JaSlk09fdkisoOFaJ7LtCyqkXK5n0AKIQigPdSh
         BpBA==
X-Gm-Message-State: AC+VfDzphRjyEC0LWQQ/fSF0eN0vjfdI8baqll88CYmUTP7WVXo7dNvH
        iV0abozAUK0RNMoFF1tBASBepA==
X-Google-Smtp-Source: ACHHUZ5uBaS+Vs92J0AT6i0i6DWL2Oh99vhbTu9sYIkmkzB0zT68q445XTXpwUF6X18AWl/lHjE+GQ==
X-Received: by 2002:a05:6a20:729d:b0:100:3964:6cb with SMTP id o29-20020a056a20729d00b00100396406cbmr2377315pzk.40.1686755160386;
        Wed, 14 Jun 2023 08:06:00 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id x17-20020aa793b1000000b00640dbf177b8sm10547721pff.37.2023.06.14.08.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 08:06:00 -0700 (PDT)
Date:   Wed, 14 Jun 2023 08:06:00 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Jun 2023 08:05:58 PDT (-0700)
Subject:     Re: [PATCH] dt-bindings: riscv: cpus: drop unneeded quotes
In-Reply-To: <20230614-credibly-pluck-0495779ada5d@spud>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-32141387-ea5c-4aea-b0b2-ac22c18b4cab@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 08:03:18 PDT (-0700), Conor Dooley wrote:
> On Wed, Jun 14, 2023 at 07:46:12AM -0700, Palmer Dabbelt wrote:
>> On Fri, 09 Jun 2023 07:21:17 PDT (-0700), Conor Dooley wrote:
>> > On Fri, Jun 09, 2023 at 04:07:06PM +0200, Krzysztof Kozlowski wrote:
>> > > Cleanup bindings dropping unneeded quotes. Once all these are fixed,
>> > > checking for this can be enabled in yamllint.
>> > > 
>> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> > 
>> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> 
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> 
>> Did you want me to pick this up in the RISC-V tree, or is it aimed somewhere
>> else?
>
> Usually subsystem, or in this case arch, maintainers should take the
> bindings patches. So that'd be you ;)

Cool, it's queued up.  I'm just put a bunch of stuff in the queue and I 
think something's failing so it might take a bit to make for-next.
