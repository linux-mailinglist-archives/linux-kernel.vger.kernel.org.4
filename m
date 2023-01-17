Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF09766DDFC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjAQMp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbjAQMpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:45:55 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A843867E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:45:53 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e130so4317446yba.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vxknlLDnsxojLcmQ59vK0ZLgoKiVLvxFkDDOG8faM4Q=;
        b=uqcNVH96+N3QhwEoMwCX0XF8bNjcpWqYdeKTdHchHyJ1W9LW/wuK5nUhmLsPUlqcjz
         7kV/qMP8k1vWUT7gagwrWaw7KqPt9kl/O1+irrBaSgnivLTfRy1btFgNHs0Gl7SiH9ji
         A532CpWpeNHRHouB4wkT/dQOWzRCmCVnPNfD0yz9tD2N5LAH6g28XDE2L5EmjbPp6huX
         HmiS0kgY0TYGihNMa3JOOZNERhi1bTob47MaH4+Nrpum65ConMPIFPErUsUSkUeMwqmm
         3hVtI2/l7sxxTNcHAoq5MxayhbFf0SXOt3b2IzUI8MGo0MOoUV//HbK6Oam84fX+IabD
         kN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxknlLDnsxojLcmQ59vK0ZLgoKiVLvxFkDDOG8faM4Q=;
        b=3Zl7qF/2R4lKjz9FfCuc+QzaJv8kxvMyqIcT5lCPNOqZy/umVDXDfrE9lm+FCPvhr4
         3YFgKjAgh0XLvd1wIJ6WLxGN45zXG8rBE/qkxC4EkreNJhVYA8FV1Ouyf+l6j3sN5PAK
         iMSl0R2++WBtz0hDTV88k0rr7rgTHMiodb03hU3G5getN4sBspsfTiaQFtyVahO/7Zl+
         fU5ktsOjttq3RpKdjj+8xTZZgWKnvP/zhKzzBg94h5j8SoblZFmSbhJ/QX7Hja276Sr4
         5QzMhavT8xuBBgUsM3iUlQQODjab8n/ZvYEyc0wFYjn4OMmav989zYo3O3KQ2RXFgbjM
         J0wQ==
X-Gm-Message-State: AFqh2kpnEjBFQGyC+jGh2qdz4ExWDV6pT0Hs0ZSeXhkmx6aM4npsXZ7v
        o17KeYiSrJq5MKqT1lq+n01VTKN8ZAJb204jzfi5Aw==
X-Google-Smtp-Source: AMrXdXuPODb5km1vVWLEOajbQIs4XSX8t9jdXpVQTtsxlKrB6VmMItgiux+DXoc2jwTxQ8qklnWstNG6QM+ZlY6ut2o=
X-Received: by 2002:a25:ca81:0:b0:7d2:891e:ee59 with SMTP id
 a123-20020a25ca81000000b007d2891eee59mr439542ybg.152.1673959553051; Tue, 17
 Jan 2023 04:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20230109174511.1740856-1-brgl@bgdev.pl> <20230109174511.1740856-3-brgl@bgdev.pl>
 <bbd21894-234e-542e-80ec-8f2bb11e268e@linaro.org> <843eed4b-552a-a529-83ed-b813c1346c5f@linaro.org>
 <CAMRc=MfTynAACwy+hB+FxOQ=-gA+307viz7LCUk8zmn4H7BaOQ@mail.gmail.com>
In-Reply-To: <CAMRc=MfTynAACwy+hB+FxOQ=-gA+307viz7LCUk8zmn4H7BaOQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 17 Jan 2023 14:45:42 +0200
Message-ID: <CAA8EJpp=w=PurE8GYBOPWmz5GnuXPo8Wyd=Xho0M_yNRciG+0w@mail.gmail.com>
Subject: Re: [PATCH 02/18] clk: qcom: add the GCC driver for sa8775p
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org, Shazad Hussain <quic_shazhuss@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 at 14:44, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Jan 9, 2023 at 10:06 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On 09/01/2023 19:58, Konrad Dybcio wrote:
> > >
> > >
> > > On 9.01.2023 18:44, Bartosz Golaszewski wrote:
> > >> From: Shazad Hussain <quic_shazhuss@quicinc.com>
> > >>
> > >> Add support for the Global Clock Controller found in the QTI SA8775P
> > >> platforms.
> > >>
> > >> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> > >> [Bartosz: made the driver ready for upstream]
> > >> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >> ---
> > > [...]
> > >
> >
> > As the driver didn't get to the list, I'll comment OOB.
> >
> > Please use clk_regmap_phy_mux_ops where applicable (PCIe PIPE clocks).
> >
>
> Looks like it's impossible for this platform as the PCIe PIPE clocks
> have two parents.

That's the point, please check the history of other platforms. XO
becomes the 'off' state rather than being a separate parent.

-- 
With best wishes
Dmitry
