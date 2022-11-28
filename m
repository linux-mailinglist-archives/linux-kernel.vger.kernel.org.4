Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6A363AFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiK1Rpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiK1Ro7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:44:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98C82B608
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:41:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id ns17so3398317pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6q4jScSzGE0hAs6a/t+5ZN33uNwYVBNck/2+9CXYC4=;
        b=3YCmph2XTQjXPW2kQT44/lBSrcV2BpRf8B02K4M0/F0zlARwt7BGO0FcrBDliS9A7e
         KSGO9p0Y4xwzZjBDLlxLkqrKn+FEejPq6VjkurShbb1t0lKoH5cVLbMmm1pcPl2n2LJ9
         6M9b3v+sWvKoE/ufm5tUBe8hi+74vzGrEoDNh3o12n9UDjrAlAG8W8dA4+FgSalqIUxS
         oM6DyysQ1akZoli2Le3BzsQHneQDybzTtEFheRLnkBxAxjoBcS6jlF43Q/bcVLDE5sIG
         uaCB4b+aOjDkQR75H5qSJU7HsZnF4KpnvH8blWmbZjcCtg98z5jqsjGBwoK61xJgQavv
         nRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6q4jScSzGE0hAs6a/t+5ZN33uNwYVBNck/2+9CXYC4=;
        b=hvQA4owJkq/tiSpRwTZMAK9gc3diWfTGpjz0x1lrPIxM/6/w7EPiQ+UdjoAuqEI0ru
         JARvyjktxM9dgjnDryKkDHpAX80+iTSARTuFqqe9oFid4y0JRsrpiI5tbLcMEYVfFJzm
         AbfM8JDqhRFK7nmAVZvdBgvpw9RTtrrsekB1hlhDRE5UHOpUmLGEkQeiSYJkuaJpO50P
         p4+1xdbVu0yBiaVIOSaCejFA2UwwrRDHzOdKF4SANLvWV14MQ6CCqG72WlWUJeyU/FiV
         aF351kc/k2a6YyB48BP3ssxb/DwI+RP8cFisRv/xN14ON+HHcjN6F+SCIy/4Ds3G7jTx
         GtLQ==
X-Gm-Message-State: ANoB5pkTSjHAB1C85EFcjmaFLdW5glQaHJZ4UVz2Uzk0pBbt+/IQ1f1E
        5DsthqBMWCwdz5u/A2uMws2dcg==
X-Google-Smtp-Source: AA0mqf4BG7cD7dOe75eRk/tyoHpPS6XhRbTW4R2+xH79QjQ5xTv8FablNNAruRzdzGGKgyVqnix98g==
X-Received: by 2002:a17:902:c1c9:b0:188:fcda:1141 with SMTP id c9-20020a170902c1c900b00188fcda1141mr32581936plc.62.1669657263784;
        Mon, 28 Nov 2022 09:41:03 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id z25-20020aa79f99000000b0056b95260b91sm8336914pfr.67.2022.11.28.09.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:41:03 -0800 (PST)
Date:   Mon, 28 Nov 2022 09:41:03 -0800 (PST)
X-Google-Original-Date: Mon, 28 Nov 2022 09:40:54 PST (-0800)
Subject:     Re: [PATCH 2/2] dt-bindings: riscv: fix single letter canonical order
In-Reply-To: <7034611.lOV4Wx5bFT@diego>
CC:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com, guoren@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-fee0e650-fb2d-4e36-8f75-ef90d5028f41@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 05:42:20 PST (-0800), heiko@sntech.de wrote:
> Am Donnerstag, 24. November 2022, 14:04:41 CET schrieb Conor Dooley:
>> I used the wikipedia table for ordering extensions when updating the
>> pattern here in foo.
>
> 	    ^ foo? :-)
>
>> Unfortunately that table did not match canonical order, as defined by
>> the RISC-V ISA Manual, which defines extension ordering in (what is
>> currently) Table 41, "Standard ISA extension names". Fix things up by
>> re-sorting v (vector) and adding p (packed-simd) & j (dynamic
>> languages). The e (reduced integer) and g (general) extensions are still
>> intentionally left out.
>>
>> Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
>> Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>
> So I have compared the new pattern to the isa manual,
> and it looks like the order checks out, so

Which ISA manual?  There have been many mutually incompatible ISA string 
encoding rules, at least one of them was a change to the extension 
ordering.  It's not entirely clear what the right answer is here, as we 
can't really parse ISA strings without also knowing the version of the 
ISA manual we're meant to parse them against.  Maybe we just accept 
everything?

IMO it's time to just stop using the ISA string.  It's not a stable 
interface, trying to treat it as such just leads to headaches.  We 
should just come up with some DT-specific way of encoding whatever HW 
features are in question.  Sure it'll be a bit of work to write that all 
down in the DT bindings, but it's going to be way less work than trying 
to keep around all this ISA string parsing code.

I know I've said the opposite before, but there's just been way too many 
breakages here to assume they're going to stop.

> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
>> ---
>>  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> index e80c967a4fa4..b7462ea2dbe4 100644
>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> @@ -80,7 +80,7 @@ properties:
>>        insensitive, letters in the riscv,isa string must be all
>>        lowercase to simplify parsing.
>>      $ref: "/schemas/types.yaml#/definitions/string"
>> -    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
>> +    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
>>
>>    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
>>    timebase-frequency: false
>>
