Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B85773FF83
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjF0PSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjF0PSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:18:47 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EFF139;
        Tue, 27 Jun 2023 08:18:46 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3427426f2ddso17563435ab.3;
        Tue, 27 Jun 2023 08:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687879126; x=1690471126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ijvb8ydCjVx69xo9+vKY/Fihoj6jCn6HLLMClNeKu1Y=;
        b=fopIXnDGcoxH0NVYoV55zHfYTgKIQMhD8yqY4dCLY1RfZ7azeFMGgSuz1jSeDNDUtR
         U2yo37rp9VuEITPDDvPKzsrGYK8J8lSz1/BAmB+5EBDpD+bcn+fBINFQu0OeVvhYsewb
         cgNwlq98Jw6LDKDDLDGvavDAMldPIWG3Xg3rFI7RVWV7ZwF64RzAyG8sT0uAqGnhjst1
         YCtW78O2JDy6rocVCWs7oU/rUukvwtRJeLbYRMECTsicio6DDSwVbdtm9QEuzxRZW62m
         gWqf/lWL91cTP8ILkZ5LoeCNt2oksOU433bsiYLVG6qd3OMUkqKSbXTgCuRIX2ySybna
         ahaA==
X-Gm-Message-State: AC+VfDz3OFd1Q1QjRZE+sQc4ACISk+gUj0khsK0l2GD1L0ygUUJ0Vx78
        S8pK/e0iM1KnkpaeojTQVg==
X-Google-Smtp-Source: ACHHUZ5+u6YK1dd/NS+7qcjA0Vmzepc5iGw59nl8ff+an8BSu5Z6+ijf/GnTk3jYyxo+5wioMbUn5A==
X-Received: by 2002:a92:c841:0:b0:345:bfc7:d527 with SMTP id b1-20020a92c841000000b00345bfc7d527mr1335127ilq.7.1687879125686;
        Tue, 27 Jun 2023 08:18:45 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h13-20020a056638062d00b004290a22e4cdsm1954955jar.108.2023.06.27.08.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:18:45 -0700 (PDT)
Received: (nullmailer pid 1933897 invoked by uid 1000);
        Tue, 27 Jun 2023 15:18:42 -0000
Date:   Tue, 27 Jun 2023 09:18:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] scsi: dt-bindings: ufs: qcom: Fix warning for sdm845
 by adding reg-names
Message-ID: <20230627151842.GB1918927-robh@kernel.org>
References: <20230623113009.2512206-1-abel.vesa@linaro.org>
 <20230623113009.2512206-6-abel.vesa@linaro.org>
 <cd84b8c6-fac7-ecef-26be-792a1b04a102@linaro.org>
 <CTK1AI4TVYRZ.F77OZB62YYC0@otso>
 <20230623211746.GA1128583-robh@kernel.org>
 <CTMDIQGOYMKD.1BP88GSB03U54@otso>
 <d3970163-b8e8-9665-3761-8942c28adaa8@linaro.org>
 <CTMFNWKMSCJP.DBPZEW25594L@otso>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CTMFNWKMSCJP.DBPZEW25594L@otso>
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

On Mon, Jun 26, 2023 at 10:19:09AM +0200, Luca Weiss wrote:
> On Mon Jun 26, 2023 at 9:41 AM CEST, Krzysztof Kozlowski wrote:
> > On 26/06/2023 08:38, Luca Weiss wrote:
> > >>>> but I guess no resends and it can be superseded.
> > >>>
> > >>> Right, the patches got reviews but was never applied... I really need to
> > >>> find a strategy to keep track of sent patches until they're applied with
> > >>> my work mailbox, it's not the first time that a patch has gotten
> > >>> forgotten.
> > >>
> > >> There was an error reported on the above series. Why would it be 
> > >> applied?
> > > 
> > > The error report at [0] complains about reg-names but I'm quite sure
> > > that patch 2/3 resolves this error. Does your bot only apply one patch
> > > at a time and run the check or apply all of them and then run it? It's
> > > been a while but I'm fairly sure I ran all of the checks before sending
> > > since I also documented some other patches in the cover letter there.
> >
> > You did it in cover letter, not in the patch, so there is no dependency
> > for bots recorded.
> 
> I'm not aware how to put extra comments into a patch in a series with
> b4, at least last time I checked I don't think it was possible? But I
> also thought the cover letter was exactly there for giving some
> background of the series and documenting any dependencies on other
> patches.

I just put a '---' line and comments after that in the commit messages. 
That works fine unless your git branch is going upstream directly (i.e. 
via a pull request). Even when I apply my own patches, I get them from 
lore and apply so the comments are dropped.

Rob
