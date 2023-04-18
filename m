Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A898C6E6F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjDRW3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDRW3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:29:16 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D48E5C;
        Tue, 18 Apr 2023 15:29:13 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id b8-20020a056820134800b00546f139ded4so885252oow.11;
        Tue, 18 Apr 2023 15:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681856953; x=1684448953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=db9PMHM/Qn98GSD4/ys+i9eCeTPLiGiM+3j8knhblLE=;
        b=DdH8u6TvdO59BNIvUCFbWbncMUqsXqhRFZ23+8IeqpHePPhS5IPU6w+XJj5xrOCEAW
         +Yx5Er/DGLV6D98efek9SGdb8dnsQS/81dKGxrjUrla8MtIUzWRBGNivYw4mdUhbKIet
         BeQQQAdpB5yYn6twMzVjfNnbnMtXhyh29Am2Pwt53tVWbOk8UHqAcEpH2Z89Bj4sD0Zc
         9MXferTKqzYYMWiWPJZYg/piEUuJwnOhx1nusOGRhj9bScb7UOeZf6gko4pVx5qn9f+S
         gM7H1LqZLlDUg/6mvqx+amRTWiIRANxy8yxWCVxHhX2BCy+d3g4xHN7mjoQJeJskRtam
         MZvA==
X-Gm-Message-State: AAQBX9fLbsQ95Kn+UC0RxpHH7dU7WyRicl2Mho9RCYZ3cz6fMZjW99rF
        WyOqVBWLnXi0OLH07hQyJA==
X-Google-Smtp-Source: AKy350bAeSIuzj8yPGX5PIb4p4EJBNSdItbfFSe5fZAkxlfdQzq90VsiHCw3NU3aEUKFTKJ/jOnUzA==
X-Received: by 2002:a4a:33c3:0:b0:541:b514:77eb with SMTP id q186-20020a4a33c3000000b00541b51477ebmr3108899ooq.2.1681856952661;
        Tue, 18 Apr 2023 15:29:12 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z137-20020a4a498f000000b00545b549c2f1sm3687486ooa.22.2023.04.18.15.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:29:12 -0700 (PDT)
Received: (nullmailer pid 2442808 invoked by uid 1000);
        Tue, 18 Apr 2023 22:29:11 -0000
Date:   Tue, 18 Apr 2023 17:29:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yangfl <mmyangfl@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clk: Add basic register clock controller
Message-ID: <20230418222911.GA2439926-robh@kernel.org>
References: <20230416194624.1258860-1-mmyangfl@gmail.com>
 <81ed4e15-19ea-34d9-3e05-d1195b2cdd57@linaro.org>
 <CAAXyoMPShMwVjckmYRxStv=t=_GiNmqdLVUUjuxvVLdvp+-4Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMPShMwVjckmYRxStv=t=_GiNmqdLVUUjuxvVLdvp+-4Rw@mail.gmail.com>
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

On Tue, Apr 18, 2023 at 02:16:28AM +0800, Yangfl wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 于2023年4月17日周一 14:27写道：
> >
> > On 16/04/2023 21:46, David Yang wrote:
> > > These clocks were provided in `include/linux/clk-provider.h`, but lacks DT
> > > bindings. Add DT bindings for them.
> > >
> > > v2: split clock controller and its clocks
> >
> > I gave you several comments on v1 and this vague changelog entry
> > suggests you ignored all of it.
> >
> > Implement feedback and respond to each one that you ack it or disagree
> > with it.
> >
> >
> > Best regards,
> > Krzysztof
> >
> 
> All issues have been addressed in v3 patch. I omitted details in
> changelog to reduce redundancy. If that is not the proper way to make
> response in dt maillist, please let me know.
> 
> Responses for each comments in v1 and v2 have been sent against original email.

Go look at v1 replies. This series is a hard no.

Rob
