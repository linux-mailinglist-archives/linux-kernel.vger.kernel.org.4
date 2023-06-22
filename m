Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B51573953E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjFVCHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjFVCHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:07:52 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5361BD8;
        Wed, 21 Jun 2023 19:07:42 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-341c362a851so25841685ab.2;
        Wed, 21 Jun 2023 19:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687399662; x=1689991662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nX4L8ejzBqvRUr9f62UT6M7EQgUf9/KqzPDQhJBYawU=;
        b=aXePOFL9OvqiG6cIDeGr6SQANqkqilMshy02oVeNj5BNVDfsbpHBwCp0nUU+8YkKVV
         ZpmbkhWdFrpRx4D/VxaMSfz+XvVHesuCg1umbatMEukePHwtEcJNLi1+NKki6U69cb9D
         POjOvdlqtMp836OulpNgM5bXGqGnOo6lYZRGrbU9DJslwPw+33L0w7cJ6eCr3GfZ8M/U
         GekRiRLrmEQmfzZublqCO5gsXYJ++Bp3ZGBdg5XKpBLKnHdCYPuvghQrHrziUDIoAFV2
         Qi1MfcwapE+mqH4OTg960AJPbmz198vRPeAPwDdBUJzuNgyFwKbOheE0+7/9lQVekNoj
         M6PQ==
X-Gm-Message-State: AC+VfDz5Z98yPOGQWhkqBJQjf2q0iA5kVvBrnu2/93oS3UrpqnL5olYU
        miJTYIveJblHLpQqbMSriQ==
X-Google-Smtp-Source: ACHHUZ7tPd0zVOkisTOC6GV02QUpZy9KMeMbVVC0nbsj9YGKPDZv+3VOVws/Inlptwbj9LyRxwCEWg==
X-Received: by 2002:a05:6e02:610:b0:331:9c03:dada with SMTP id t16-20020a056e02061000b003319c03dadamr13558953ils.13.1687399662203;
        Wed, 21 Jun 2023 19:07:42 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s14-20020a92cb0e000000b0034267d3fcc5sm1680494ilo.55.2023.06.21.19.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:07:41 -0700 (PDT)
Received: (nullmailer pid 67903 invoked by uid 1000);
        Thu, 22 Jun 2023 02:07:39 -0000
Date:   Wed, 21 Jun 2023 20:07:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 3/3] dt-bindings: usb: Add binding for Cypress HX3 USB
 3.0 family
Message-ID: <168739965923.67844.7517249183491573877.robh@kernel.org>
References: <20230620-hx3-v4-0-e56b3c6db60b@skidata.com>
 <20230620-hx3-v4-3-e56b3c6db60b@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-hx3-v4-3-e56b3c6db60b@skidata.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Jun 2023 20:04:05 +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> The HX3 family comes in different variants (up to 4 USB 3.0 ports;
> multi-TT), e.g. CYUSB330x/CYUSB331x/CYUSB332x/CYUSB230x.
> 
> This initial version of the binding only describes USB related aspects
> of the HX3 family, it does not cover the option of connecting the
> controller as an i2c slave.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>  .../devicetree/bindings/usb/cypress,hx3.yaml       | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

