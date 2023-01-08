Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1372B661994
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjAHUyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbjAHUyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:54:06 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CFF10566;
        Sun,  8 Jan 2023 12:54:05 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id i1so516740ilu.8;
        Sun, 08 Jan 2023 12:54:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKnNpQNdzdLgMMqd20StxieGNrz33GPSfX+GftpfArA=;
        b=69N5QzLyQwdW784v2ExJk9/7ESOysW0L4C/jbki2dq/nU/QrP1hl2QkoQ5hrWxtlSH
         rmCGjbTplifE4bq5TeEFcMTFTsBr9v+zMfMgsMpT5Ec57PO6ua9AtEKl4Zpj7TnWtvDy
         +twCWk//MZsDfKiIjmlUXLK1vcwzmxGzuVKMQW+4qgIoEvhTVkNb+l03KQ2pWbTENhSI
         E/We5pToA2bhxtT/HiXBoMGGoZa9MxfaoZ2BhSCC+YwEaAhIaUcZllTGID2GXs5jnj64
         aHf/fgKjlKif7V5gAH+EczfEsFgHGDmnUC8Re/2JXn6hdOxKKAU46d0cE3J6yoLypyOm
         XAfA==
X-Gm-Message-State: AFqh2kpkL9vkYbid2AF1oVWW2m+5dAWXxZ+flZS0Z0w4r9LmUG/uZGh/
        LtsTqpZ26AfmCOBLB2j7sZWikH9Eaw==
X-Google-Smtp-Source: AMrXdXuD97K0zSgLYBr6hvBS4jKAj99eoH7O0k7hsPy3oE3DQWUsf0GqPtn1v6cmHrUEnMgWWMuQTQ==
X-Received: by 2002:a92:dd83:0:b0:300:a953:a263 with SMTP id g3-20020a92dd83000000b00300a953a263mr49546522iln.21.1673211244943;
        Sun, 08 Jan 2023 12:54:04 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id z18-20020a92d6d2000000b003039e7d680fsm2257683ilp.11.2023.01.08.12.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:54:04 -0800 (PST)
Received: (nullmailer pid 260770 invoked by uid 1000);
        Sun, 08 Jan 2023 20:53:43 -0000
Date:   Sun, 8 Jan 2023 14:53:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: iommu: sun50i: Add compatible for
 Allwinner D1
Message-ID: <167321122261.260695.4785173456346736432.robh@kernel.org>
References: <20230103010903.11181-1-samuel@sholland.org>
 <20230103010903.11181-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103010903.11181-2-samuel@sholland.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 02 Jan 2023 19:08:58 -0600, Samuel Holland wrote:
> D1 contains an IOMMU similar to the one in the H6 SoC, but the D1
> variant has no external reset signal.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v2:
>  - Disallow the 'resets' property for the D1 variant
> 
>  .../iommu/allwinner,sun50i-h6-iommu.yaml      | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
