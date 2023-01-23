Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A1F677D06
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjAWNtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjAWNtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:49:10 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B02FAD;
        Mon, 23 Jan 2023 05:49:07 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id r9so10350649oig.12;
        Mon, 23 Jan 2023 05:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z6DjlBFUwbR0WUBdCx1J7JkLvsBkMvycGqa1UEcwyI4=;
        b=Ns71RMn/kEuOge83tDWZxf1T3s7bqd5uwIpT9EWMkLBnTaSi4bQRqjU+Mam8GRWTeD
         NvhxNEkrNhszMC/sMZ75lBivq1bDBOhbJLfovnFSP73kCr/8cCVx/klLYpxlqyJkLO18
         9twe7NGLtxSB1qDPJtgzJKilZXpSgGCKeZ3zVe94J53wO2sa0Py1nwlTDHj29aqTCA5+
         NOHWYWXrrhoSIfxWczvvEgV5y9GKT72w12T9bo57M0dqyZy7ajGYuSwHbMjiuQJ0xATO
         wvR+/dBi7zQhWMApfuT7tCJANDmzgAjnS8SQfyjPinDlFKe6jM9eGd2zY0DyuwdpvNki
         uUnQ==
X-Gm-Message-State: AFqh2kq4+bUL8sh4MKkvn0Sgi+oaoGETcL4JbvKvGBNaaQE6+RSicmK2
        82DRA4yLO5IT9NWwG9EYrQ==
X-Google-Smtp-Source: AMrXdXvta/6yY5vnM7qO6fDv9MVUQ9H1Qsd1IEy9Vk4TL0tzaMHtqwXt3RyNofhrV4Wm1QgqEe5T5Q==
X-Received: by 2002:aca:5942:0:b0:360:e96a:8748 with SMTP id n63-20020aca5942000000b00360e96a8748mr9798578oib.15.1674481746127;
        Mon, 23 Jan 2023 05:49:06 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r2-20020a056830120200b00670641eb272sm5176854otp.20.2023.01.23.05.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:49:05 -0800 (PST)
Received: (nullmailer pid 1354422 invoked by uid 1000);
        Mon, 23 Jan 2023 13:49:02 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20230122174548.13758-1-ansuelsmth@gmail.com>
References: <20230122174548.13758-1-ansuelsmth@gmail.com>
Message-Id: <167448145441.1342371.14502432252817277201.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr
 bindings optional
Date:   Mon, 23 Jan 2023 07:49:02 -0600
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Jan 2023 18:45:47 +0100, Christian Marangi wrote:
> The qcom-cpufreq-nvmem driver supports 2 kind of devices:
> - pre-cpr that doesn't have power-domains and base everything on nvmem
>   cells and multiple named microvolt bindings
> - cpr-based that require power-domain in the cpu nodes and use various
>   source to decide the correct voltage and freq
> 
> When the schema was introduced, it was wrongly set to always require these
> binding but this is not the case for pre-cpr devices.
> 
> Make the power-domain optional and set them required only for qcs404
> based devices.
> 
> While at it also make more clear what the opp-table supports by adding
> ref to the opp-v2-kryo-cpu and opp-v2-qcom-level schema.
> 
> Fixes: ec24d1d55469 ("dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 81 +++++++++++++------
>  1 file changed, 56 insertions(+), 25 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230122174548.13758-1-ansuelsmth@gmail.com


/: opp-table-cluster0:opp-1036800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-1056000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-1113600000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-1132800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-1190400000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-1209600000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-1228800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-1286400000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-1324800000:opp-supported-hw:0:0: 13 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-1363200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-1401600000:opp-supported-hw:0:0: 13 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-1440000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-1478400000:opp-supported-hw:0:0: 9 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-1516800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-1593600000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-1593600000:opp-supported-hw:0:0: 9 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-1996800000:opp-supported-hw:0:0: 32 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-2188800000:opp-supported-hw:0:0: 16 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-307200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-307200000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-384000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-422400000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-460800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-480000000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-537600000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-556800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-614400000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-652800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-691200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-729600000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-768000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-844800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-844800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-902400000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0:opp-960000000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0:opp-979200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster0: Unevaluated properties are not allowed ('compatible', 'nvmem-cells', 'opp-1036800000', 'opp-1113600000', 'opp-1190400000', 'opp-1228800000', 'opp-1324800000', 'opp-1363200000', 'opp-1401600000', 'opp-1478400000', 'opp-1497600000', 'opp-1593600000', 'opp-307200000', 'opp-422400000', 'opp-480000000', 'opp-556800000', 'opp-652800000', 'opp-729600000', 'opp-844800000', 'opp-960000000', 'opp-shared' were unexpected)
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster0: Unevaluated properties are not allowed ('compatible', 'nvmem-cells', 'opp-1056000000', 'opp-1132800000', 'opp-1209600000', 'opp-1286400000', 'opp-1363200000', 'opp-1440000000', 'opp-1516800000', 'opp-1593600000', 'opp-1996800000', 'opp-2188800000', 'opp-307200000', 'opp-384000000', 'opp-460800000', 'opp-537600000', 'opp-614400000', 'opp-691200000', 'opp-768000000', 'opp-844800000', 'opp-902400000', 'opp-979200000', 'opp-shared' were unexpected)
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-1036800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-1056000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-1113600000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-1132800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-1190400000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-1209600000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-1248000000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-1286400000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-1324800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-1363200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-1401600000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-1440000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-1478400000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-1516800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-1555200000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-1593600000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-1632000000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-1670400000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-1708800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-1747200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-1785600000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-1804800000:opp-supported-hw:0:0: 14 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-1824000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-1900800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-1977600000:opp-supported-hw:0:0: 48 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-2054400000:opp-supported-hw:0:0: 48 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-2150400000:opp-supported-hw:0:0: 48 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-2246400000:opp-supported-hw:0:0: 16 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-2342400000:opp-supported-hw:0:0: 16 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-307200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-307200000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-384000000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-403200000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-460800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-480000000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-537600000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-556800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-614400000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-652800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-691200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-729600000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-748800000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-806400000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-825600000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-883200000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-902400000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1:opp-940800000:opp-supported-hw:0:0: 15 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1:opp-979200000:opp-supported-hw:0:0: 112 is greater than the maximum of 7
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

/: opp-table-cluster1: Unevaluated properties are not allowed ('compatible', 'nvmem-cells', 'opp-1036800000', 'opp-1113600000', 'opp-1190400000', 'opp-1248000000', 'opp-1324800000', 'opp-1401600000', 'opp-1478400000', 'opp-1555200000', 'opp-1632000000', 'opp-1708800000', 'opp-1785600000', 'opp-1804800000', 'opp-1824000000', 'opp-1900800000', 'opp-1920000000', 'opp-1996800000', 'opp-2073600000', 'opp-2150400000', 'opp-307200000', 'opp-403200000', 'opp-480000000', 'opp-556800000', 'opp-652800000', 'opp-729600000', 'opp-806400000', 'opp-883200000', 'opp-940800000', 'opp-shared' were unexpected)
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

/: opp-table-cluster1: Unevaluated properties are not allowed ('compatible', 'nvmem-cells', 'opp-1056000000', 'opp-1132800000', 'opp-1209600000', 'opp-1286400000', 'opp-1363200000', 'opp-1440000000', 'opp-1516800000', 'opp-1593600000', 'opp-1670400000', 'opp-1747200000', 'opp-1824000000', 'opp-1900800000', 'opp-1977600000', 'opp-2054400000', 'opp-2150400000', 'opp-2246400000', 'opp-2342400000', 'opp-307200000', 'opp-384000000', 'opp-460800000', 'opp-537600000', 'opp-614400000', 'opp-691200000', 'opp-748800000', 'opp-825600000', 'opp-902400000', 'opp-979200000', 'opp-shared' were unexpected)
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb

