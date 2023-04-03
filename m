Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8413E6D5109
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjDCSvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjDCSvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:51:19 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E2E30D6;
        Mon,  3 Apr 2023 11:51:19 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id x8-20020a9d3788000000b0069f922cd5ceso16160908otb.12;
        Mon, 03 Apr 2023 11:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680547878;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VMz6yQ2bZF7BlHMDiB3FYTfbUexueivojNLXyF5+Ac=;
        b=4PnQOKY25zoL+0Ra8VvuMLikpu4OBPLo2yu6+xSRYAdW9w1DAHLP3WUwQDpcff9309
         d2pqoNA8gGrh6YtlmAZTOGS/cUZY8gKwMiewT6/kM/5VjRL5vSdUY+NlSFVXQ8B6N2Gn
         2Qd9gP1Gga7B5OYDWnuLEF6cOFY66rGHmgRxwuj3lVbSq9g+8gHFRL24zIb9zgoscrS7
         HS28vQY3ZZXakrBRITq7LleCIufSf5Zqf6d2GwD6fSlzhmPmTQ+8sW9t7lg3Gvri6vRU
         1PK0WSmvUGvzdCQwJ6DSmhJiSaVZ3kETwAtx5xKgr5dPZr55ZzXqF7h5x4A09JARdw5D
         iNFA==
X-Gm-Message-State: AAQBX9f+CQ5Cny7FL+tv2VqO2w6KPMZuXOSFimbfu6hVg5Q3D4HaU66q
        ODRMHNOPeJIpi8tBvmw3+A==
X-Google-Smtp-Source: AKy350ZBdrGhyaEOnP99b9h+HMjQ3GXqoGKlrzWLuKi4myNNe6IM8Nd+vePR4Ch0XRiM5BoczT4F6A==
X-Received: by 2002:a9d:6949:0:b0:6a2:e9f3:6e9e with SMTP id p9-20020a9d6949000000b006a2e9f36e9emr103317oto.13.1680547878276;
        Mon, 03 Apr 2023 11:51:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q16-20020a056830019000b0069fb87285fdsm4539451ota.59.2023.04.03.11.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 11:51:17 -0700 (PDT)
Received: (nullmailer pid 1362747 invoked by uid 1000);
        Mon, 03 Apr 2023 18:51:17 -0000
Date:   Mon, 3 Apr 2023 13:51:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V6 1/3] dt-bindings: nvmem: layouts: add fixed-layout
Message-ID: <168054787680.1362688.9993524807419287721.robh@kernel.org>
References: <20230327141611.25131-1-zajec5@gmail.com>
 <20230327141611.25131-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230327141611.25131-2-zajec5@gmail.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Mar 2023 16:16:09 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> With the introduction of NVMEM layouts, new NVMEM content structures
> should be defined as such. We should also try to convert / migrate
> existing NVMEM content bindings to layouts.
> 
> This commit handles fixed NVMEM cells. So far they had to be defined
> directly - as device subnodes. With this change it's allowed to put them
> in the DT node named "nvmem-layout".
> 
> Having NVMEM cells in separated node is preferred as it draws a nice
> line between NVMEM device and its content. It results in cleaner
> bindings.
> 
> FWIW a very similar situation has happened to MTD devices and their
> partitions: see commit 5d96ea42eb63 ("dt-bindings: mtd: Clarify all
> partition subnodes").
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V6: Add unevaluatedProperties: false
> ---
>  .../bindings/nvmem/layouts/fixed-cell.yaml    | 31 ++++++++++++
>  .../bindings/nvmem/layouts/fixed-layout.yaml  | 50 +++++++++++++++++++
>  .../bindings/nvmem/layouts/nvmem-layout.yaml  |  5 +-
>  .../devicetree/bindings/nvmem/nvmem.yaml      | 19 +------
>  4 files changed, 84 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
>  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

