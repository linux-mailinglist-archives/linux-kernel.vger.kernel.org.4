Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7F772EC54
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbjFMTxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjFMTxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:53:06 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C82CE3;
        Tue, 13 Jun 2023 12:53:05 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-76c64da0e46so268687639f.0;
        Tue, 13 Jun 2023 12:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686685984; x=1689277984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFF9yKVxZTmwGftTglpqWvlcX4ivJd8HOQxUjLCVDrc=;
        b=HFMxzrVm/R3qb2OeKCcT2aSvYPXy87Fwf5SH2fr83FmEttbhXht4Gr6/lPacEPTsz0
         O87IAuxYpGAgaFnjCMD6KAvj76aO/J13TUCJYM1NCatIXf+XVr7M3mr/ngpnZo1jzeKR
         cCMjiAp1CAk1o2nILIZ0Ac0hLNWlP8mlvAHnQM6h3NF9c4G1kCBIEFJEusYCoy7zbitp
         DOSjM7lBtf2P5vV/Ue8BMnVHMlG6pQHmm5wfhD7pma4PDNSSF9+b9wBXIRddJe+kGjZ6
         maI+BAiIS2y/QYzyWyFvrQom1/ZD9B8rem1eeHvjqmwSPi9+Ml8BdWwrlH5i397qYgjo
         2/0g==
X-Gm-Message-State: AC+VfDyv0lwh5F7ioLTIH2t1hcLHYRjLNN6tWXrq/hXD/G8JXDXmLO66
        eVRNiyBFUU0aVOOrG40ssw==
X-Google-Smtp-Source: ACHHUZ6axH7naaPgnju5+V8UP64sAjOwVNHmfmcTyrY7IgbMSKMQ7+TbSESewQtMeKZHe9DNg8HL/Q==
X-Received: by 2002:a5e:da0a:0:b0:776:f992:78cf with SMTP id x10-20020a5eda0a000000b00776f99278cfmr11622178ioj.12.1686685984430;
        Tue, 13 Jun 2023 12:53:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t13-20020a5edd0d000000b0076373f90e46sm4097306iop.33.2023.06.13.12.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:53:03 -0700 (PDT)
Received: (nullmailer pid 2796278 invoked by uid 1000);
        Tue, 13 Jun 2023 19:53:02 -0000
Date:   Tue, 13 Jun 2023 13:53:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, quic_bgodavar@quicinc.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        quic_hemantg@quicinc.com
Subject: Re: [PATCH v2] dt-bindings: net: Add QCA2066 Bluetooth
Message-ID: <168668597983.2796176.858314477197972698.robh@kernel.org>
References: <20230530082922.2208-1-quic_tjiang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530082922.2208-1-quic_tjiang@quicinc.com>
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


On Tue, 30 May 2023 16:29:22 +0800, Tim Jiang wrote:
> Add bindings for the QCA2066 chipset.
> 
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml   | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!

