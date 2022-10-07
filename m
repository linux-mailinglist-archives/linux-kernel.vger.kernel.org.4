Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232075F72F4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 04:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJGC6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 22:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJGC6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 22:58:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B4EFE774
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 19:58:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id i3so3755787pfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 19:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoj5EGA0RYL9Ka7luDj/60Kyu1sOVCj/9jFFGeRwP9Y=;
        b=TnY1XKauPWQ8k6BJT+TkH6jngPwzD2M3I3/ivPWAnBOsOtikW4DiG4DRqNmcDv5jsP
         3T+fYGrtt72fkJ1McvY1lk7El+YU43Duy+HskVv6oQ62Trw+yHvgEz8kkSbVukb1Dv3K
         DT/dQSDulksE1an7I8Lr/HA4FsE6gzs3MlzQ5M9mufsti74syB7DQmfPiurh7MedYo5J
         e5MTPJTo8YnKq52+gl9WFVBKMeCnpKX11vgZEDBSJMn7M2oWkXK/wxxO6U5+W2BvSujY
         VtjiE0O0Y+OkvTmVeh6GsPy2C07afAa5xFm3rica75E5DK/xkgnbepy9AiXEbvsX2WoN
         zZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoj5EGA0RYL9Ka7luDj/60Kyu1sOVCj/9jFFGeRwP9Y=;
        b=Qxh7yR41pQnG/SfPWGlvDnpqpHQraEC8a66/8dAaspPPfeALNAeeeYVZvQLhOSEXO1
         /EilQ4UFxXy3VWGm6izc7cS/6wBPNoC/PqPwQxYjlEtJdSWQ+Yj3TOSW23yznnWHS56H
         MdfZxZtBgty/0JUIN3W5Q63l1rJMV6OEtnKPneIDMokrcFH3mnN7Si8kP2zqixxyiPEm
         u54F77fpIEDR83N1zmy+L1HUbQUg6PT8cEib+NXHUyfSItDlu5awyp7k7nmFsJK2d3bn
         DScd7JwAFz3zOPCDKWyNPsZBgEaqB429z95VcZhcZKpWqRaoahTx3DbNTfvmp32PeyDY
         Gxdg==
X-Gm-Message-State: ACrzQf0zc38tZdHWGyT3a+M3lZ1HTCjBidPvwfDTgIBv0K2tBsUi9Tco
        0KHAnulOsSteauFHwZd74jGF6A==
X-Google-Smtp-Source: AMsMyM4aHddStVwHJEdJraLuB8qK0pz3TytQVfIvQWiHygu27A1LUyhoO+y89+6zBj1fLgqb9CWA1w==
X-Received: by 2002:a63:6986:0:b0:43c:8417:8dac with SMTP id e128-20020a636986000000b0043c84178dacmr2559548pgc.286.1665111486224;
        Thu, 06 Oct 2022 19:58:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v66-20020a622f45000000b00561b6705d6esm337550pfv.219.2022.10.06.19.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 19:58:05 -0700 (PDT)
Date:   Thu, 06 Oct 2022 19:58:05 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Oct 2022 19:51:34 PDT (-0700)
Subject:     Re: [PATCH 1/3] dt-bindings: sifive-ccache: rename SiFive L2 cache to composible cache
In-Reply-To: <20220829062202.3287-2-zong.li@sifive.com>
CC:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-050016e5-0f50-4366-b4bd-98b4b36a56bb@palmer-ri-x1c9>
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

On Sun, 28 Aug 2022 23:22:00 PDT (-0700), zong.li@sifive.com wrote:
> Since composible cache may be L3 cache if private L2 cache exists, it
> should use its original name composible cache to prevent confusion.
>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  .../riscv/{sifive-l2-cache.yaml => sifive-ccache.yaml}      | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive-ccache.yaml} (92%)
>
> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
> similarity index 92%
> rename from Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> rename to Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
> index 69cdab18d629..1a64a5384e36 100644
> --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
> @@ -12,8 +12,8 @@ maintainers:
>    - Paul Walmsley  <paul.walmsley@sifive.com>
>
>  description:
> -  The SiFive Level 2 Cache Controller is used to provide access to fast copies
> -  of memory for masters in a Core Complex. The Level 2 Cache Controller also
> +  The SiFive Composable Cache Controller is used to provide access to fast copies
> +  of memory for masters in a Core Complex. The Composable Cache Controller also
>    acts as directory-based coherency manager.
>    All the properties in ePAPR/DeviceTree specification applies for this platform.
>
> @@ -27,6 +27,7 @@ select:
>          enum:
>            - sifive,fu540-c000-ccache
>            - sifive,fu740-c000-ccache
> +          - sifive,ccache0

Looks like Rob's bot had comments and I don't see a v2.  Sorry if I'm 
missing something.

Also: I'd guess that we only had the SOC-specific mappings on purpose.  
It's kind of a grey area and I'm OK either way, but I'd definately 
prefer the DT folks to get a chance to review these.  My guess is that 
they're not looking due to the bot comments, but sorry again if I've 
missed it.

>    required:
>      - compatible
> @@ -37,6 +38,7 @@ properties:
>        - enum:
>            - sifive,fu540-c000-ccache
>            - sifive,fu740-c000-ccache
> +          - sifive,ccache0
>        - const: cache
>
>    cache-block-size:
