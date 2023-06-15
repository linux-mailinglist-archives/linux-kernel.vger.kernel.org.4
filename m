Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4AC731EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbjFOR0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjFOR0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:26:06 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C00A2719;
        Thu, 15 Jun 2023 10:26:02 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-33b3f2f7989so33644285ab.0;
        Thu, 15 Jun 2023 10:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686849961; x=1689441961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exG2p6jfHrkVt3gD9cpzVxY9zfQ5o6txkxlgxOC4V5s=;
        b=D+jxxCwXpAbQBBTy5p+KsDA/ixkNvO1I3crka9hMw9xVJnvVKLHW/rtjm9qp09eh1I
         QJrsf8K17f52B5Xq6oTfuJNG3hM1I+DTkZElL25O/wWOwF7VpyBBrNtMUswQqS5G5I6L
         8Nk/qtKAKbCU0Sc6KoVF5WuQByF7U05nX0Xvh7BYx4Ve0LHsJlsM5kB7izmS/BcKBaAJ
         sCPCywjX79hoZmDqPzwxITfFYwZiDYVLmzi/2jTyxxdF7MFx4kkLGRU6J0SAZJHf2e7N
         NJqXD8+f/F0eZ4ePiu9ZgUks2QUJK6G1JdveZd3gseEKBvMl3CoeeBcGt903P65O9D4A
         m7Yw==
X-Gm-Message-State: AC+VfDz171NRnztsVEF98MpZmPi6WQEd505bqh/fMGeE5RXyqcC9Ay6Z
        wQ6991IpCc1hzSQ99Pqk6A==
X-Google-Smtp-Source: ACHHUZ5OY/78Q9+EkXUtW7QfRE97v9U6izCvlVvD/gTXPhcjQEVg8gjTo1ksk34UZZ7sQlobY0qPWw==
X-Received: by 2002:a92:d686:0:b0:341:d9e7:9d94 with SMTP id p6-20020a92d686000000b00341d9e79d94mr31146iln.25.1686849961169;
        Thu, 15 Jun 2023 10:26:01 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v24-20020a02b918000000b0041a9022c3dasm5730248jan.118.2023.06.15.10.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 10:26:00 -0700 (PDT)
Received: (nullmailer pid 1229216 invoked by uid 1000);
        Thu, 15 Jun 2023 17:25:58 -0000
Date:   Thu, 15 Jun 2023 11:25:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: net: bluetooth: nxp: Add missing type for
 "fw-init-baudrate"
Message-ID: <168684995787.1229168.16425251556673819198.robh@kernel.org>
References: <20230613200929.2822137-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613200929.2822137-1-robh@kernel.org>
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


On Tue, 13 Jun 2023 14:09:29 -0600, Rob Herring wrote:
> "fw-init-baudrate" is missing a type, add it. While we're here, define the
> default value with a schema rather than freeform text.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml    | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Applied, thanks!

