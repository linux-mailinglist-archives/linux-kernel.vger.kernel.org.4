Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F59606030
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJTM3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJTM3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:29:34 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C89713F8E;
        Thu, 20 Oct 2022 05:29:27 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id i65so17043637ioa.0;
        Thu, 20 Oct 2022 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbdJ4Peu/E38/32Na4oJOo5P/t/pYNcwFTsRn1CFdQY=;
        b=TyhPJkyGmsgHkM6VTj5ZF6j/yBnW3wKzbb0eo7yGqS0KzjHLVm2YIfK5GMHosvmg+S
         pHcCwADi6/GMWThazL155mg1YKNl9SfWT6vLAk/AGe6GOheDvUKo8rWFyHUtGEd3OJoV
         rw1K7JPKE0ru5dqMI7ogq8TCp/Vm4m5GySiZpe/sWDWBCW15VDfs2e6X9s+SK2c+EfP4
         JcmCJNGuK8ZkcHum3yhlyJvzy8GHjNoS6YBj1rA6ecDI7hkix3dM3QB+k5ni72UNLfxl
         Ex6DUmn9Y8SJzZYHCxPD74tvHHdepIHEB3OmJ7AilbLhtvlFiKeCBn+BDXSH7t3iahC5
         cq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbdJ4Peu/E38/32Na4oJOo5P/t/pYNcwFTsRn1CFdQY=;
        b=O3hT+Ix/xyyaY1zho7gqeiGctCBtOM7Agksf0KMPNnzOPy8p1vKqxAfSVEye9WIP99
         FtkJGIT3DVyAmBEULC7gQyG3BOx9AWfMNPtziMyyrikXcDg2YHEwRPQDOgPOk+UIfr4R
         PMdbLIB+mC8p5PqIsG4utUVRltqnlX2kMYBt2XPsEgQXtcaLdAfYu6ny+500gaxfiaQQ
         XhSyOu+opwhpCqHIFhIvS31nxNaOAvJnFCIQcbsnTjE8Ojc7z00V2++jugxr1rkTZXXM
         +3KA2XVpAidHjkHQxID/3+4dprPqSWqjUILvxvDBjjnHzgFiLl2VPUDSIa1mM7V7QTxu
         dwfg==
X-Gm-Message-State: ACrzQf0iGlHOaUJjl3sT8WjWI7rAh7mcLkwvgILOMXslTfRO2DGgyY7f
        GR8RGbYNMeqqdv0T94VyfQy7iEP6jZ5udCGGGho=
X-Google-Smtp-Source: AMsMyM44PndMIt9F+Oo2TK6GgTPokgUODgaLemVzy82ml3MDdlkJTgd+6KE13KqICkXNxlX84EXS3TEoamZZnZbjabI=
X-Received: by 2002:a6b:ba41:0:b0:6bd:1970:16ac with SMTP id
 k62-20020a6bba41000000b006bd197016acmr1886486iof.15.1666268966631; Thu, 20
 Oct 2022 05:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221016132648.3011729-1-lis8215@gmail.com> <166609251307.155136.11548088283059583394.b4-ty@kernel.org>
 <CAKNVLfbfRRE3O2uFH6MQxoa_cdqTUcvpGzmcxFm3oCLKFfHv6w@mail.gmail.com> <Y1E7nFC9DcdqegKX@sirena.org.uk>
In-Reply-To: <Y1E7nFC9DcdqegKX@sirena.org.uk>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Thu, 20 Oct 2022 15:29:15 +0300
Message-ID: <CAKNVLfYc8FP6g1+nFAwEVizFg1dDtU-Qj79ZX3-_P1=y0XSKQA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] ASoC: codecs: jz4725b: Various improvements and fixes
To:     Mark Brown <broonie@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-mips@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=87=D1=82, 20 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 15:14, Mark Brown =
<broonie@kernel.org>:
> This was already fixed by Colin...

Wow! Thank you all, guys!
