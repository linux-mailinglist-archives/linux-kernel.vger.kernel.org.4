Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0388468142C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbjA3PLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbjA3PLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:11:11 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A9D39282;
        Mon, 30 Jan 2023 07:11:10 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id r9so10285680oig.12;
        Mon, 30 Jan 2023 07:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lHdh1CkCtIdFTXxL0MnkKjoUkZTHAxzc6MiEiiVEVU=;
        b=OpGvB8hT5gecMjpBgt8xQtyc0v6FByV2BugfTvXxJcR+0ppB8wqzgWc5e8o1PemL+V
         ksC/uLec7i01ia0ECT7LZuZqQ52wxwcqKnNsxtYWSJltHWZUxMAW1gunci/Vr9OhZirp
         7jXLyWGDwH1PatYB91uFXpmFnyK2hsbC+QH0Zt+Q1II66OQE2qTeIZTaG3SvGl3eFAxt
         5gQg9CGP8/f4jNMUk+9T5nz1Z6WKQXJLMBe8ZOfda8XOnwoRjsj1Cdny2XUfMSyt+mTz
         wLVN1af0KhMoFfBtvEVsdwXBM5XHXHNcu6nTxhvP3ajvnjqQwZNLmc8Bm1u/q9YheJtO
         iVzQ==
X-Gm-Message-State: AFqh2koc56n2sSONs8eRpbGg7bBmH0Mr7o7EthJ8/Un3yoCRFV0gekum
        uBtZbTULhGe1MEJo96YUFA==
X-Google-Smtp-Source: AMrXdXtih+BIOtVOCT9uywHOqVTZZLIqiwGALi32V+KKFVD5odraFJnotVWrWvyiMnBWA25gnXCZQA==
X-Received: by 2002:aca:c2c6:0:b0:363:a5fd:9cc7 with SMTP id s189-20020acac2c6000000b00363a5fd9cc7mr21476755oif.13.1675091469441;
        Mon, 30 Jan 2023 07:11:09 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s9-20020acadb09000000b00363ea5be014sm4839405oig.3.2023.01.30.07.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:11:09 -0800 (PST)
Received: (nullmailer pid 2585826 invoked by uid 1000);
        Mon, 30 Jan 2023 15:11:08 -0000
Date:   Mon, 30 Jan 2023 09:11:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-remoteproc@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mathieu.poirier@linaro.org, mani@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: remoteproc: qcom: Add sm6115 pas yaml
 file
Message-ID: <20230130151108.GA2548714-robh@kernel.org>
References: <20230128053504.2099620-1-bhupesh.sharma@linaro.org>
 <20230128053504.2099620-2-bhupesh.sharma@linaro.org>
 <167491555142.2364868.11831106421472878617.robh@kernel.org>
 <8c954218-bba4-54c8-59a2-86371610aa03@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c954218-bba4-54c8-59a2-86371610aa03@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 12:08:34PM +0100, Krzysztof Kozlowski wrote:
> On 28/01/2023 15:20, Rob Herring wrote:
> > 
> > On Sat, 28 Jan 2023 11:05:04 +0530, Bhupesh Sharma wrote:
> >> This documents the aDSP, cDSP and MPSS DSPs present
> >> on the SM6115 SoC.
> >>
> >> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >> ---
> >>  .../bindings/remoteproc/qcom,sm6115-pas.yaml  | 143 ++++++++++++++++++
> >>  1 file changed, 143 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
> >>
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > ./Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/remoteproc/qcom,pas-common.yaml
> 
> This is expected - the qcom,pas-common.yaml is in remoteproc repo.

Where is that dependency mentioned in this patch? If not mentioned, I 
will mention it for you with the error report.

Rob

