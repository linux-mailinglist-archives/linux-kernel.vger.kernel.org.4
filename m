Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5D26B14DF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCHWRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCHWRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:17:01 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657AC86164;
        Wed,  8 Mar 2023 14:16:59 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id s41so201297oiw.13;
        Wed, 08 Mar 2023 14:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy6uSriJqriuTV3y6TloMSMjjacDQbvnLKJ8hjpK170=;
        b=KuT/eWGFluIcAIfuF3b5HNdVYd1/LhXoyZdiHvpBD9a7kwjPiTy71EWW5pvY7NXtbm
         +NLgHK85cxTkRMQNa49Cj3e3sXXudNcLZfnrXX9z2TtZg3ftb5/s1ngx6rJZurHQaJ+V
         Le+HWw+baCjM3tJK1Z48yHD0DS1cVbyNcRK7eFMpzK/CL2JRJ4HQxt7teK6ClMxH94PL
         ZyRiDOHZSqMkBZ1BITxycoij/ZngksGoflQAQQFeHY5l3ZDHojtRKFNx2U87z/lFCCDt
         PjQo3ANAE8BApYthLi/s+MJqsyYCihzdeeiO3QcvST8woP5854usDphdJeXXAHz6edAe
         mEGA==
X-Gm-Message-State: AO0yUKU5h3yJV640iEsMJh0G2BK5YruFwOfEa111qE/8smXhSeOaUwmy
        NXjs6yaii36TYyZmUeQPKQ==
X-Google-Smtp-Source: AK7set8N8yHv+GYi+rTefKkPVUXSfz9QKK35/Gj82g6DaPQTNIKyCAGGytc/631/AVCEFhFARQ/a5w==
X-Received: by 2002:aca:f1a:0:b0:384:210d:a649 with SMTP id 26-20020aca0f1a000000b00384210da649mr7708391oip.59.1678313818598;
        Wed, 08 Mar 2023 14:16:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e129-20020acab587000000b003847ca255fasm6892584oif.30.2023.03.08.14.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:16:58 -0800 (PST)
Received: (nullmailer pid 3944342 invoked by uid 1000);
        Wed, 08 Mar 2023 22:16:57 -0000
Date:   Wed, 8 Mar 2023 16:16:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM
 interface
Message-ID: <20230308221657.GA3935330-robh@kernel.org>
References: <20230305022119.1331495-1-luzmaximilian@gmail.com>
 <20230305022119.1331495-4-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305022119.1331495-4-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 03:21:18AM +0100, Maximilian Luz wrote:
> Add bindings for the Qualcomm Secure Execution Environment interface
> (QSEECOM).

Pretty sure I already asked, but no answer in the commit message. Why do 
we need this? You've already declared the platform supports SCM calls 
with "qcom,scm". Why can't you probe whether you have QSEECOM or not? DT 
is for non-discoverable h/w we are stuck with. Why is software made 
non-discoverable too?

Nodes with only a compatible string are usually just an abuse of DT to 
instantiate some driver.

Rob
