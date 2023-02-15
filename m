Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E396984EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBOTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjBOTri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:47:38 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95C841B54;
        Wed, 15 Feb 2023 11:46:31 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id eq11so25127007edb.6;
        Wed, 15 Feb 2023 11:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0gY6fPU2wIKz3O7JKb5l+ZOzMIrxO+gU/Fm6ycOW600=;
        b=CHXE1eU9oJnw19JirsAUnDO3tkBMRfy1btendDMBP5AvRrQ0274GX5pCHVg7IW85Xl
         Y0kqwtXxmIT3Vla8GB5aF5QlCVLGN9Y+j8vIsdXZ6xhhetLg/qhA7nrwF666eFQy/ZYJ
         4N46YnXGiVfvZRwo1LP6ndb9jq0kCL1xXNTlK8feWZhgJxM46rkHNOCD1ZGUh4IgvE9g
         A7SE6tXe4M5bDAWr3LtRZRPlUv3/YDSTzjM4J8Au9ixcKNg9V7SNiGl/eTlPZkslqUg9
         K6lwqBminK/H7J3SMiR7JkR7ybvL8GdZyVcqfAQz2diVErk4UGA5xOouUohCzwC+pwDr
         767Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gY6fPU2wIKz3O7JKb5l+ZOzMIrxO+gU/Fm6ycOW600=;
        b=5EgudC5k3yDK17cxIV7a4ikUSPZ8oeRzR0iGcsSCj+EQz4lnVF0gNbg7gSs3Zz2qX3
         7wugu7pnXguRhGpnMB2d1+y3uFWayrHOYDxdfxC0Ys6dKTV4y+IbG/gv2N49ffm+uSW3
         OV5DGtNhIXVtV7iaJLfTliEh39uWN88CYhaVVzKeLRdEE91nkC+qhC23I2+rm5SCH989
         BuGAcyRrY1v1OFe3p7lSULaIfRMy2+nEOM3SNYKbW2wBe7SFI0DiYWGt49bLbbG2skyn
         wojKEeSflT6ABJ+Su6jwReWbcFB/Hu2cazGwhrkDqvGpTfaYdZCUSpdWQ012GN/vrPWb
         4rUA==
X-Gm-Message-State: AO0yUKUyS9gLQt3Qy2KKM2DhdLF+Nr5nkIbGd70XUEdoQU/usFYdsqWe
        zQk8pSSMplde506lavYBLgOqCmhtjrK6XIhvJlrTQ8PI
X-Google-Smtp-Source: AK7set+5UINGYpxfOT+JqbbXrDGaMZhcao3eRocx2Q849cXbeJg5nU66qqezg0N3hP3F2iUPkmOt4fymeqb7uO0SUdE=
X-Received: by 2002:a17:907:68b:b0:877:747d:1112 with SMTP id
 wn11-20020a170907068b00b00877747d1112mr1645959ejb.15.1676490388540; Wed, 15
 Feb 2023 11:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
 <20230208101545.45711-4-krzysztof.kozlowski@linaro.org> <20230215192123.4ore7ac6tnedrsyq@ripper>
In-Reply-To: <20230215192123.4ore7ac6tnedrsyq@ripper>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 15 Feb 2023 13:46:17 -0600
Message-ID: <CABb+yY1xHOac4C7fWHW6Cj67-O7nBWFP8LXbW-9V_F24b1SMTA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] dt-bindings: mailbox: qcom,apcs-kpss-global: drop
 mbox-names from example
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org
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

On Wed, Feb 15, 2023 at 1:19 PM Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Wed, Feb 08, 2023 at 11:15:42AM +0100, Krzysztof Kozlowski wrote:
> > Qualcomm G-Link RPM edge bindings do not allow and do not use mbox-names
> > property.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > ---
> >
> > Changes since v1:
> > 1. None.
> > 2. Previously was sent as separate patch.
> >
> > There are no strict dependencies. This can go anytime. The next patch
> > (glink-rpm-edge) should be applied in the same or later cycle (could be
> > via different trees).
>
> Jassi, I missed this note and merged the following patches, introducing
> the forecasted issue in linux-next. To remedy this, I took the liberty
> of merging this patch as well into the remoteproc tree.
>
No problem.

Cheers.
