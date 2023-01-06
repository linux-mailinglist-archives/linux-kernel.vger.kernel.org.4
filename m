Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EB1660659
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 19:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbjAFS1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjAFS1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:27:50 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8195878A7A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 10:27:49 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id g16so2456334plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 10:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmLntltvaFSn7Veu63eW90yAOw0MaICZcm5KPVBm5q0=;
        b=Nr4kJ40YcqDfsKaUZ0YQwjQt+oUhlKaj7wrZU+FbgBRK+rHM2gR59ezPl+jDTnrd7N
         d14inXDd/GtOfntsdQGOFiETBXi0NtPbEN6PhQTZ/SmB6/akAjPMNB1kOEsZ3LKCYSeL
         3utYn4aCVg/eFs1xvGv0ei2SmqWSiJT2FgeAHtk7pyatwvO8Uzsc6/bmZdmfsz3ShXs6
         EkU/W8NTtoIkcC8FUxKEa1/PLoiWbDgO4oyYF1HDbrls2e0y5e4yMwqNUrvyYhkb5Kxl
         yLGqRZoNFHHjvCNDfgZdA+9IfG7/8u7Rw0Ecy6jIeMkOo7aYK24Yyi6xB7MMgXsIl4RU
         A2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmLntltvaFSn7Veu63eW90yAOw0MaICZcm5KPVBm5q0=;
        b=korEcgrad3BUUirjPkBgTiqxFE0OibZqaOnp2h+SASJdp65UJR49Qhf+EirCn1rf+K
         +Kyq9kPwKFIt7qNYHiAAuC83B7fIRpST+QsVp1tq9GDyiZQz6S+SQvMZZu+ialfBrxmv
         8DMyWRUh/uMObDmBqanfqxRjE/KDHPRt5a+TM5JQ4RkpfiDsEM9caGYDqKUV+6r6TJll
         Zp9aCBxUaS1G7gAPE3QBxg4E7UX3FdTxa9kraHRtSa8an0qNYDutwVG7VUkL+4mbRjH1
         UrslCT7bUo9Nr75Do+hxbuper3vzVbXbq1/DJ59bTRgiHlt1EcfayimyqXKOOxC4LS7P
         NAQQ==
X-Gm-Message-State: AFqh2kq6oF0eV0rS6DSOEeSf34CCFGCoP76ICyOp6AhBt3Xcxoa+5dRU
        XsARCXzLs1QrAajMGzsrV1ZAFw==
X-Google-Smtp-Source: AMrXdXs27suwfr9jMMc5hET4poLfufr4skSeto59CNAGRWkccUXezkYj6qZh3nG8wWM9skVoBh9qvg==
X-Received: by 2002:a17:903:251:b0:192:9369:b2fe with SMTP id j17-20020a170903025100b001929369b2femr35212915plh.38.1673029668806;
        Fri, 06 Jan 2023 10:27:48 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b00189c9f7fac1sm1291845plg.62.2023.01.06.10.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 10:27:48 -0800 (PST)
Date:   Fri, 06 Jan 2023 10:27:48 -0800 (PST)
X-Google-Original-Date: Fri, 06 Jan 2023 10:27:46 PST (-0800)
Subject:     Re: [PATCH v3 0/2] riscv,isa fixups
In-Reply-To: <20221205174459.60195-1-conor@kernel.org>
CC:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>, jrtc27@jrtc27.com,
        Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, heiko@sntech.de, ajones@ventanamicro.com,
        guoren@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-e3f1a8a9-2d89-4331-bb8a-b798af0cb277@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2022 09:44:58 PST (-0800), Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> I noticed ~today~ while looking at the isa manual that I had not
> accounted for another couple of edge cases with my regex. As before, I
> think attempting to validate the canonical order for multiletter stuff
> makes no sense - but we should totally try to avoid false-positives for
> combinations that are known to be valid.
>
> All I've changed for v2 was collecting tags & adding in the missing
> commit reference that Heiko pointed out.
>
> v3 fixes an issue Jess spotted - it's *any* multi-letter extension that
> can come immediately after the single-letter ones, not just ones
> starting with Z.
>
> @Palmer, either you can take this once the DT folks have ACKed it if you
> like, or I will take onto some v6.2-rcN fixes branch. I don't think that
> there is any urgency :)

Sorry I missed these.  

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

We can just do a shared tag if you have stuff that depends on them?  
That'll let me keep fixes clean, as I'm running the DT stuff too now.  
Though maybe it doesn't matter so much because I'm not really taking any 
DT stuff.

> Thanks,
> Conor.
>
> CC: Jessica Clarke <jrtc27@jrtc27.com>
> CC: Conor Dooley <conor@kernel.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: Heiko Stuebner <heiko@sntech.de>
> CC: Andrew Jones <ajones@ventanamicro.com>
> CC: Guo Ren <guoren@kernel.org>
> CC: linux-riscv@lists.infradead.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
>
> Conor Dooley (2):
>   dt-bindings: riscv: fix underscore requirement for multi-letter
>     extensions
>   dt-bindings: riscv: fix single letter canonical order
>
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
