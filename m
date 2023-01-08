Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB866617B3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjAHSAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjAHSAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:00:52 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395255F51;
        Sun,  8 Jan 2023 10:00:51 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l1-20020a17090a384100b00226f05b9595so4967780pjf.0;
        Sun, 08 Jan 2023 10:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ng9Gr1gYRwK5vNJRL60sb9VXFUxVbbixwT/syyuNq4=;
        b=l9eP+VBu4hhhlcaXjk+bP9h/4ECNSarc3fgEVwQidAWu+ldqCXjjWX3qWqsGHC44wJ
         6103/aENAEqV3c+tLGKUhn9e8Fin0Nz642lZPsinGUoDJjffOcnTKr+7LgNdz0sML4c0
         o+f/SO7ZaM7XHNJZTf0FVH/dxJ3MJ407H+eo6qH+ZS5Qg3lDmsAEemHNQIK/+4+JfApc
         1HQYvVVqHYqlTUPsPgaZ2oelzFUSzAP2DvoPyGdV0p1tD2I2296yEGYYQ7GJ5RqGjLA0
         0vdw1MRSz5eR8v89rcgw/DKWmk8ye0nOWePEP+g8XDj2GTAvrHCs7Rag87TlgPlJss90
         XlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ng9Gr1gYRwK5vNJRL60sb9VXFUxVbbixwT/syyuNq4=;
        b=TRi1aC8rLGMLXtEhs7IMx0XOz+jzrsEeASZrMYhTKufJO0mjwiEirsrUydYk7qBItP
         W0KxsbXNVL7JE45HLZhimxd7Y5ns25N9wlC8b99cDWD3KpvM83dmGjHWr4F5ZZmRY1LA
         UF8+uvDilHYOiV8s3bbnrajvmk1xpKzoG1J1IoD0aAlCHjAU8GQJa2u3J8dTOS3PpZR6
         p/+4e6sZSIp+SnNiaL4vhyUMkThmbLmjzWq/+w+Ayvti9aTsHEaMeT9+P8Ia5bTUyEA2
         Y1H7RPB5uyBmkxbIvLrechL8uzXuV7wjmwQchXyaYEXSJzizAzC2a20YOpx9k+DLCW6u
         m9BQ==
X-Gm-Message-State: AFqh2kr+IxzUGpUVLzcTpMSRCMzDvx8IQY0T62y5TAnnNnh7KaFgFqaD
        QGW1PW8qf0o1SZClG0+rwf2rTB0pbGgZnXkyhK4=
X-Google-Smtp-Source: AMrXdXvCQY64/Qfang/RtUtn9MlrQYL56huSKMOB9PhktnzHAsXmXMUSPJ/Cq2qq39FQSUVEhJhV5+ueZ0gQmC1Z0QQ=
X-Received: by 2002:a17:903:1204:b0:192:fe7e:c41b with SMTP id
 l4-20020a170903120400b00192fe7ec41bmr1076772plh.57.1673200850655; Sun, 08 Jan
 2023 10:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20230108130440.670181-1-robimarko@gmail.com> <CAA8EJpqR9w2maBB_ABXk7ggxD34WKvQS+m79-ua-nN50H79nOw@mail.gmail.com>
In-Reply-To: <CAA8EJpqR9w2maBB_ABXk7ggxD34WKvQS+m79-ua-nN50H79nOw@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sun, 8 Jan 2023 19:00:39 +0100
Message-ID: <CAOX2RU6aqrK-dXhzduxHdwE94L1w5Pc3cBTt8iYRotxQ9cWBjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: qcom: ipq8074: populate fw_name for usb3phy-s
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2023 at 18:34, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sun, 8 Jan 2023 at 15:04, Robert Marko <robimarko@gmail.com> wrote:
> >
> > Having only .name populated in parent_data for clocks which are only
> > globally searchable currently will not work as the clk core won't copy
> > that name if there is no .fw_name present as well.
> >
> > So, populate .fw_name for usb3phy clocks in parent_data as they were
> > missed by me in ("clk: qcom: ipq8074: populate fw_name for all parents").
> >
> > Fixes: ae55ad32e273 ("clk: qcom: ipq8074: convert to parent data")
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> Ah, excuse me, this is what I asked for in the other patch. We can
> only hope to see these clocks added to the gcc DT node.

Yes, there are PCI pipe parenting fixes waiting for review, so I plan to add
both to GCC node after that.

It would be great if you can take a look at the IPQ8074 PCI support series.

Regards,
Robert
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
>
> --
> With best wishes
> Dmitry
