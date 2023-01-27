Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8E467EC2E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbjA0RLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjA0RLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:11:37 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CB37B7B8;
        Fri, 27 Jan 2023 09:11:10 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id y19so5321132edc.2;
        Fri, 27 Jan 2023 09:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUxpuvJ/VHJaLIeLYnuRlg6jDsLtCejrbzt/O2zp+ZQ=;
        b=IbaGeWez18I6i2D+ir8sVW69k+wa8ji8cW9iELJ8QTTvkisd7LELywspbpwKjv/tsM
         /754sKeLinmKbmonRdQ3ueDtEgjMvh6/HiQQm7iZyGqgYl9F/HnUCmBUQLImxeoQuyrm
         EjrWqKOaAPLQHs5eDleQ1Gn/047aJNSLVZNgDl9arur0b7uhOfCVKZ0eNeTqcN5QIQb1
         WkbTaFzIu8/5D8z/sRM9TN0T/Wkk5IN2Z5apJr1kD5yijb/ArCE+eYTEYGwt6Gxo0OmQ
         CW8uYQs0BsaJuDDVNZ+RzZtjs46c/7KdrAfFkV6I2XX18SSv+uGupNTHe39859/eaXwh
         Cc+Q==
X-Gm-Message-State: AO0yUKV3ddbyiK+waseEoz0CibkIl/Wqc+SubX88Vsjoe0da5uT3j2Os
        CWyQsumifgQ5r8KqH3VafpGb2J4urnSpcA==
X-Google-Smtp-Source: AK7set8vdkXQ42gZuenaiaRXxN+mnvdWOMVVdKTV1W27mOJjDObJcj4ESaY4cRC6Y1jtW1OFzshVEA==
X-Received: by 2002:a05:6402:419:b0:4a0:b640:6505 with SMTP id q25-20020a056402041900b004a0b6406505mr8744081edv.34.1674839435381;
        Fri, 27 Jan 2023 09:10:35 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id l19-20020a056402255300b00488abbbadb3sm2585405edb.63.2023.01.27.09.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 09:10:34 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1140812wms.4;
        Fri, 27 Jan 2023 09:10:34 -0800 (PST)
X-Received: by 2002:a05:600c:1c8b:b0:3b4:6c36:3f59 with SMTP id
 k11-20020a05600c1c8b00b003b46c363f59mr1621701wms.100.1674839434612; Fri, 27
 Jan 2023 09:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20230120184500.1899814-1-martin.botka@somainline.org> <20230120184500.1899814-2-martin.botka@somainline.org>
In-Reply-To: <20230120184500.1899814-2-martin.botka@somainline.org>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 28 Jan 2023 01:10:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v678GtZEZiiH_RB5=6UUqCDqPGg6kp6US_s+pKs1oBWWGw@mail.gmail.com>
Message-ID: <CAGb2v678GtZEZiiH_RB5=6UUqCDqPGg6kp6US_s+pKs1oBWWGw@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: mfd: x-powers,axp152: Document the
 AXP313a variant
To:     Martin Botka <martin.botka@somainline.org>
Cc:     martin.botka1@gmail.com,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 2:45 AM Martin Botka
<martin.botka@somainline.org> wrote:
>
> The X-Powers AXP313a is a PMIC used on some devices with the Allwinner
> H616 or H313 SoC.
>
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
