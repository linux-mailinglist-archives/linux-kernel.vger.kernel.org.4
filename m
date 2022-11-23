Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03326362DD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbiKWPHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238528AbiKWPHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:07:16 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38811DB1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:07:15 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e189so13347954iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w3+6kZ2jPHYC5XIhLk4GWvNk5dgTaXJHF9rl6H9TAKQ=;
        b=QxyS2jc4eEVkc7xWxzPYNIuXzGXAbZ8bAvsyjhaprQIYWaXpa8/mb0+5btpVEIRzOq
         8bFEiKF2mpWq3B87UAQu/4QBUJ0NjvxwpTCDG3HBeJsfBxgoTvxIaqeQmIotAhTSCpAr
         i3+XwQBf/22NjT/8M9cJXZNdbQN7k6L6Z5Z4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3+6kZ2jPHYC5XIhLk4GWvNk5dgTaXJHF9rl6H9TAKQ=;
        b=s27pEId+G+EzE5dJ9VVpu7a7/+ZcpX0EBzuzFV9S8SjsbYkTAlYjnMI1/7NMZ0rU1i
         lAWPr3FNolblG5dzyIgY7SxhddBiMm7bASn16AvdRn2BZU5nHUujeNFqRgKRHUFi4fnC
         yjr0ulI/fFmH9J2pQqygVB53J2CpGTxTcyIDbwu60criCNYnm6KO+ZVDECX3FES/KfqZ
         9qyKrKCwstKGXXp348y6tBIqWshGu+k7jzlNCeKjlmy6++buCSxG1dkokHcFMjWjc8cB
         sKmxUGQuv6jHt38k8UlxM/tZL32hJ+pOIeY7BAIOXap9TgZtq+yQzX7vk77ulhCeNOym
         DnaQ==
X-Gm-Message-State: ANoB5pmA4Do1hekYCvd5kAhuZaVBqcdoBHQ+aKmfmZRsTNJB2bNkkjec
        E/teWvuukwT1JslLdtStN87cFw==
X-Google-Smtp-Source: AA0mqf46YDgL+DFXaRtC//XFl6SUoUuagE8OHUpFvGoORyGX6ge4WY9xVHBXqJ5q7g4cVZOGNRJV4w==
X-Received: by 2002:a6b:1455:0:b0:6de:896e:529c with SMTP id 82-20020a6b1455000000b006de896e529cmr12735578iou.45.1669216034569;
        Wed, 23 Nov 2022 07:07:14 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id b13-20020a02a58d000000b003633848da58sm6454991jam.41.2022.11.23.07.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:07:14 -0800 (PST)
Date:   Wed, 23 Nov 2022 15:07:13 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     =?utf-8?B?5qWK5a6X57+w?= <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Harvey <hunge@google.com>, Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Abner.Yen@ecs.com.tw,
        Gavin.Lee@ecs.com.tw, Vicy.Lee@ecs.com.tw, Jason.Huang@ecs.com.tw,
        Darren.Chen@ecs.com.tw
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Adding DT binding for
 zombie
Message-ID: <Y343IWgkli+y8HMn@google.com>
References: <20221122203635.v2.1.Ie05fd439d0b271b927acb25c2a6e41af7a927e90@changeid>
 <Y3zck7tPA5WFd0p1@google.com>
 <CAPao8GKpXcRm3PmWnv+rsr2z53r6J-ScXAq+fOi4ydQg_Gy31A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPao8GKpXcRm3PmWnv+rsr2z53r6J-ScXAq+fOi4ydQg_Gy31A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 02:02:38PM +0800, 楊宗翰 wrote:
> HiÂ Matthias ,
> 
> When I run "patman" still get warning "<patch>:36: warning: added, moved or
> deleted file(s), does MAINTAINERS need updating?"

The warning is expected because you added new files. In this case you can
ignore it as it isn't expected that you become the maintainer of the new zombie
DT files.

> And I screenshot my "git gui" as below(attachment "git_gui_screenshot.jpg"):
> [image.png]
> 
> The latest git log info as below:
> ---
> commit 4d2b529bce125b83c546aebbc36ecedf76dfc55e (linux_qcom/for-next)
> Merge: 9abf2313adc1 c03fa428ac6e afcd946be11c aec5f36cf676 cea42b8d7966
> aa9f474014b1 37b5e8c48b9d cadaa773bcf1
> Author: Bjorn Andersson <andersson@kernel.org>
> Date: Â  Tue Nov 15 11:45:55 2022 -0600
> 
> Â  Â  Merge branches 'arm64-defconfig-for-6.2', 'arm64-for-6.2', 'clk-for-6.2',
> 'defconfig-for-6.2', 'drivers-for-6.2', 'dts-for-6.2' and 'arm64-fixes-for-6.1'
> into for-next
> ---
> 
> My checkout steps as below:
> $ git remote add linux_qcomÂ git://git.kernel.org/pub/scm/linux/kernel/git/
> qcom/linux.git
> $ git fetch --no-tags linux_qcom
> $ git checkout -b <MyLocalBranchName> linux_qcom/for-next
> 
> Is myÂ code base branch still worng?Â  Am IÂ missing something?Â 

My understanding is that it is best to base you changes on a branch like
'arm64-for-6.2' as the 'for-next' branch is re-created every time changes
land in one of the '${area}-for-${version}' branches.

No big issue in this case, just use the corresponding '${area}-for-${version}'
branch for future patches/versions :)

> The attachment is "0001-dt-bindings-arm-qcom-Adding-DT-binding-for-
> zombie.patch" patch file,
> Â I have drop "Documentation/devicetree/bindings/arm/qcom.yaml" as your advice.
> 
> Matthias Kaehlcke <mka@chromium.org> æ¼ 2022å¹´11æ22æ¥ é±äº æä¸10:
> 28å¯«éï¼
>      On which tree is this series based? My earlier reply bounced for
>      Bjorn's
>      old Linaro e-mail address, which suggests that the series might be
>      based
>      on an older kernel tree (maybe downstream Chrome OS v5.15?). Please
>      make
>      sure to base patches to upstream lists on the corresponding
>      maintainer
>      tree/branch or a recent kernel version/rc.
> 
>      On Tue, Nov 22, 2022 at 08:37:02PM +0800, Owen Yang wrote:
>      > Add an entry in the device tree binding for sc7280-zombie.
>      >
>      > Documentation/devicetree/bindings/arm/qcom.yaml
>      >
>      > Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
>      > ---
>      >
>      > Changes in v2:
>      > - Move binding item to Google series bottom.
>      > - Modify DT file for zombie.
>      >
>      >Â  Documentation/devicetree/bindings/arm/qcom.yaml | 10 ++++++++++
>      >Â  1 file changed, 10 insertions(+)
>      >
>      > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/
>      Documentation/devicetree/bindings/arm/qcom.yaml
>      > index c15a729a6852..f617923f7485 100644
>      > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>      > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>      > @@ -538,6 +538,16 @@ properties:
>      >Â  Â  Â  Â  Â  Â  - const: google,villager-sku512
>      >Â  Â  Â  Â  Â  Â  - const: qcom,sc7280
>      >Â 
>      > +Â  Â  Â  - description: Google Zombie (newest rev)
>      > +Â  Â  Â  Â  items:
>      > +Â  Â  Â  Â  Â  - const: google,zombie
>      > +Â  Â  Â  Â  Â  - const: qcom,sc7280
>      > +
>      > +Â  Â  Â  - description: Google Zombie with LTE (newest rev)
>      > +Â  Â  Â  Â  items:
>      > +Â  Â  Â  Â  Â  - const: google,zombie-sku512
>      > +Â  Â  Â  Â  Â  - const: qcom,sc7280
>      > +
>      >Â  Â  Â  Â  - items:
>      >Â  Â  Â  Â  Â  Â  - enum:
>      >Â  Â  Â  Â  Â  Â  Â  Â  - xiaomi,lavender
>      > --
>      > 2.17.1
>      >





