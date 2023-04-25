Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F346EE7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjDYTBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbjDYTA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:00:59 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57574CC;
        Tue, 25 Apr 2023 12:00:58 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-187af4a5437so4508563fac.0;
        Tue, 25 Apr 2023 12:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682449257; x=1685041257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGfTh6aEPBP2zPBc8sodaau12HqZshVg1l6oDdUcrhg=;
        b=FFaZiW4S7EUm/OdCLlNy2oL/ft2lWC895KmBMLN7rtUOG2CcNcrGkFb/m7RPCk+yZ6
         2eMWIkX9muQ45RBYxb5doP7OyAI0uDTXXMICAVB21M9yC7X4MX6YtzWrPVVYFIikavlq
         29jp7Ep4Ed70c+alADHaBd3Aj3PLrvXJFsOUzYaOFh/rQMN8AWFHR+Yuyv/NydgUNRQL
         TozzT9zwu7GafXLQj7z7qo8hFM7AAEKKJt6SrADG84XV0fkrLteOE3ysPpgIUJKEYa07
         ZjPN20je3+LxV+lJNp53GsrsJ132TPAJI7f+v8aZpPu4YeMKmQ5usTOXXRjw/EJvsKHK
         yGBg==
X-Gm-Message-State: AAQBX9f9rWMtjoucsdG0kuYQd0Xx2aEst4S4iBVkTl6dEM07TjgbC154
        1+9LSKvEIo1NQPZMeE2q8A==
X-Google-Smtp-Source: AKy350YhZEueyWFqwlhM7KIm3mZnkPtZe/gu70qsQmRdddqqLoErBq67vbMQCEtsBT1z0FJeUmVo4A==
X-Received: by 2002:a05:6870:330f:b0:187:7f29:b9 with SMTP id x15-20020a056870330f00b001877f2900b9mr11650647oae.13.1682449257481;
        Tue, 25 Apr 2023 12:00:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c6-20020a05687091c600b001806f2ac9a6sm5778357oaf.47.2023.04.25.12.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 12:00:57 -0700 (PDT)
Received: (nullmailer pid 2087501 invoked by uid 1000);
        Tue, 25 Apr 2023 19:00:56 -0000
Date:   Tue, 25 Apr 2023 14:00:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     robh+dt@kernel.org, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, sgoutham@marvell.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wim@linux-watchdog.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v3] dt-bindings: watchdog: marvell octeonTX2 GTI
 system watchdog driver
Message-ID: <168244924738.2086493.15313274108214738857.robh@kernel.org>
References: <20230425081926.9234-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425081926.9234-1-bbhushan2@marvell.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Apr 2023 13:49:25 +0530, Bharat Bhushan wrote:
> Add binding documentation for the Marvell octeonTX2
> GTI system watchdog driver.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v3:
>  - Used 4 spaces for entire DTS example
> 
>  .../watchdog/marvell,octeontx2-wdt.yaml       | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

