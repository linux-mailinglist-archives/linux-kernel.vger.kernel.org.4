Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6746E6C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjDRSmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjDRSms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:42:48 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBB693D7;
        Tue, 18 Apr 2023 11:42:48 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6a5da18f7f5so501679a34.1;
        Tue, 18 Apr 2023 11:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681843367; x=1684435367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX9q8gX+UiR7CnmbV0JhOILFmnfK5QRyHCsxTtqP7h8=;
        b=VoVJcBwAdrh4JPJBimftOmym+mEnRCVosHaVtm8Q1utNpkb4nU5xK3ktgJNAwnDNqp
         6/IueRXmbWyHc1KLWcZUeOUn+8ILnKGDt9l2YNsQUh/hKmZwPEb/pC2NfDM7OAjY7mqk
         fWF0OlEkID7Bq1VWAtMoBe14yvYLk7ccqtkee2EepBMom9glJDO9426mKqZ/nnJWXRXm
         skOWyW4fOYZQ06dPYxvWyr//0VVALY0bl8WXIiNoBA4HoBBGVtnafpkSw8KI0w3Nc2+v
         n/p79wGtP0bZNQUDS8N5mUspb5hrfkPeFE0wfa4JS4tCZNGhx11Q+zTwtSSW5J3k/CV4
         9JEA==
X-Gm-Message-State: AAQBX9fdb+IH40U8UR+ZlaGRxPvO7Z5B3+a38R0de2eS/utPQGm03zj4
        cz78Uy+acNyJh0AsjjScxw==
X-Google-Smtp-Source: AKy350YkFGdSrcH78VWgdiZeex/IhpEM1/tIWlB0tUde/R1j0VFPBv9n0B3D5YWlYqCkIfq6XkKf9A==
X-Received: by 2002:a9d:7454:0:b0:6a3:2513:c452 with SMTP id p20-20020a9d7454000000b006a32513c452mr1455755otk.23.1681843367361;
        Tue, 18 Apr 2023 11:42:47 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c7-20020a9d6847000000b0069f0794861asm5786365oto.63.2023.04.18.11.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 11:42:46 -0700 (PDT)
Received: (nullmailer pid 2105101 invoked by uid 1000);
        Tue, 18 Apr 2023 18:42:46 -0000
Date:   Tue, 18 Apr 2023 13:42:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Message-ID: <20230418184246.GA2103246-robh@kernel.org>
References: <20230412084540.295411-1-changhuang.liang@starfivetech.com>
 <20230412084540.295411-2-changhuang.liang@starfivetech.com>
 <8dd0dc63-e0df-8764-f756-da032d9d671c@linaro.org>
 <eb47b7c7-bdbb-92d9-ba39-604ce487f297@starfivetech.com>
 <f6a4fb28-d635-4d99-44bb-d929cb41eef2@linaro.org>
 <b34a8d59-34e4-8358-9d2b-367f4707ca7c@starfivetech.com>
 <f0d82428-aaa5-3dd4-bc29-f1057fe749bc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0d82428-aaa5-3dd4-bc29-f1057fe749bc@linaro.org>
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

On Thu, Apr 13, 2023 at 10:41:23AM +0200, Krzysztof Kozlowski wrote:
> On 13/04/2023 04:34, Changhuang Liang wrote:
> >>>>> +  lane_maps:
> >>>>
> >>>> Why did this appear? Underscores are not allowed. It looks like you
> >>>> re-implement some standard property.
> >>>>
> >>>
> >>> Will change to lane-maps.
> >>> Yes, according to Vinod advice, lane mapping table use device tree
> >>> to parse makes sense.
> >>
> >> Hm, I have a feeling that I saw such property, so you should dig into
> >> existing and in-flight bindings.
> >>
> >> Best regards,
> >> Krzysztof
> >>
> > 
> > A standard property? Like "clocks" or "resets"?
> 
> Like lane-polarities now submitted to one MIPI.
> 

data-lanes perhaps?

Rob
