Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1F8741588
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjF1Poo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:44:44 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:42338 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjF1Pol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:44:41 -0400
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-345a32f3eeaso100695ab.1;
        Wed, 28 Jun 2023 08:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687967080; x=1690559080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8qi2/hGD1+QQV7LjWPANEr9l2yFXdhrRF59lxS51Ek=;
        b=CI5QAJ/nMBEe+xR4CIrgL138WVhak4AT/8YFSWYb9j8DH+olIIa1V48455i5vQTMHj
         BflqK58zNsVtuch91RPfTjxJWqj13z/VEcBBv/mhhhvhU0W+fZxL5H0vMNcrc27FqYJf
         vbEy85SNeuMPW/JWBgarkCN7HDqodKFbtCy+o8FeOX/dTeunMVrd4CHWaUaBkG+33fHh
         QZe2dAPaOSOIEWzpe75yvRlRQPD0qEaqdySvCydAnka6umSgUQUAs/hE2Vq4mAu3cewB
         dQ8wIOS4E4dZj7/zglXmUFjRkZfsJNObAWGz5V6/VfNbOnornD5z6ny7eWKH7sWQYmZt
         npOg==
X-Gm-Message-State: AC+VfDz0wfQwF5MX3JcidD5cFLg9C0sSANm33nit9+pyslEfHb8O/oqc
        CI3T3am/6KuAFmioSlE+xh/ROuBj6Q==
X-Google-Smtp-Source: ACHHUZ79mRzg8+qZLbggc6AbavxNQm7x9oE4nROWahp4rP1eUGmg9coMWivmV3bV2fvmgRrNosi1Qw==
X-Received: by 2002:a92:d94d:0:b0:341:24f1:3f74 with SMTP id l13-20020a92d94d000000b0034124f13f74mr1285671ilq.14.1687967080305;
        Wed, 28 Jun 2023 08:44:40 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b3-20020a92ce03000000b00345c0eca0e7sm950361ilo.85.2023.06.28.08.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:44:39 -0700 (PDT)
Received: (nullmailer pid 530531 invoked by uid 1000);
        Wed, 28 Jun 2023 15:44:37 -0000
Date:   Wed, 28 Jun 2023 09:44:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Seven Lee <wtli@nuvoton.com>
Cc:     linux-kernel@vger.kernel.org, supercraig0719@gmail.com,
        dardar923@gmail.com, broonie@kernel.org, WTLI@nuvoton.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        SJLIN0@nuvoton.com, lgirdwood@gmail.com, KCHSU0@nuvoton.com,
        YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, scott6986@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: nau8821: Convert to dtschema
Message-ID: <168796707718.530473.9600429077455152027.robh@kernel.org>
References: <20230628085009.1130318-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628085009.1130318-1-wtli@nuvoton.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Jun 2023 16:50:09 +0800, Seven Lee wrote:
> Convert the NAU8821 audio CODEC bindings to DT schema.
> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../devicetree/bindings/sound/nau8821.txt     |  55 --------
>  .../bindings/sound/nuvoton,nau8821.yaml       | 125 ++++++++++++++++++
>  2 files changed, 125 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/nau8821.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

