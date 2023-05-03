Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C113A6F4FA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 07:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjECFKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 01:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECFK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 01:10:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560F5198C;
        Tue,  2 May 2023 22:10:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f137dbaa4fso366065e87.2;
        Tue, 02 May 2023 22:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683090626; x=1685682626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gUMcAb9p0mtdNtbUOeVy8zAV4NOHZstBj8s8GNLqlo=;
        b=rXbyC8wiohAIZnaCzgut2ymBY5J5zPwmSUhFhzl9ol/JU4Sy2uQwvsnu1NbXM1LMHd
         kLe6iUxw1O2vUz6cY8rvR2d3JOcgFPnDmMUOdQtgY1VXK8LUMsfCkTJ1AG6MNqk/q5bK
         kaRel+B/SFxikNOV64r3HIVJeq9ZJl1A5VlU0ANcugWa4WVbSSt5l+kxniIvkTD4/ZhE
         eI57ZB+tFb4Sct1jA7UChoyLxFZVZBgMYQe7WZZ34CxeOICI86FzQ3mkXSUaqJRHHld2
         XNNIFISSRqRhwPSGIo7u5UgPESeKIzJiaUncBqeKqT6VbKkFJDqLqO7kEpqsen3wS1JY
         u1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683090626; x=1685682626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gUMcAb9p0mtdNtbUOeVy8zAV4NOHZstBj8s8GNLqlo=;
        b=ltgAE4F5Me5/OH3tMye41UnNqUJJgySqw24jIT4hAA9pffFtoV2R89aB+PbIe2XTOl
         kdgi/c9onm67vMjcA3GTkbeq4LaC5zTKrBi8NeyyHpza19+/Nbml2p5iiKQjOIvxxz9D
         ZuX5bL+pjTnV/9TX62NnR9BVPKECafxMFcg88euVkRCSODDGKifKDwW5OGagg1cHJdzN
         hiWvB26OWXRkoGGlhdnGfNhXPgY208UYzZ3LZRmjCGqO+GuyYj+CYuyvFgIIcau51RhT
         B0BwqJfVAV80C7Vo3Y1q7xSBXdzvubBpguqKdn+7+vyviw/SpCUPfFRvwWdO45KgjCSg
         3U3w==
X-Gm-Message-State: AC+VfDzr8Tzd453vgWDOZTNetxKwSgKX4ZWs/DBg8sMrM6Ck0bxj0J0t
        +PQni4D3K9OcEKkUxRA3rXMyt/WSMLf/sR1y1A==
X-Google-Smtp-Source: ACHHUZ6HugMTcvUOsV69lbdyeCpg3dHGRyKco7GUIMPTz/WpvdDDFDxbuGmiiy/fYUIOfBPvyKlzjJqDW4B/nm4tK2c=
X-Received: by 2002:ac2:5d6a:0:b0:4dc:4b92:dbc4 with SMTP id
 h10-20020ac25d6a000000b004dc4b92dbc4mr445424lft.14.1683090626163; Tue, 02 May
 2023 22:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230427094420epcms2p1043333a3e0c0cf58e66164e0b83b3b02@epcms2p1>
 <20230427094420epcms2p1043333a3e0c0cf58e66164e0b83b3b02@epcms2p1>
In-Reply-To: <20230427094420epcms2p1043333a3e0c0cf58e66164e0b83b3b02@epcms2p1>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 3 May 2023 13:10:13 +0800
Message-ID: <CAGaU9a9B7gAfJk8F_4_v3OAYuGA2MAAOEbq09aJrbhCZqo7CaA@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: core: Change the module parameter macro of use_mcq_mode
To:     keosung.park@samsung.com
Cc:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keoseong Park <keosung.park@samsung.com> =E6=96=BC 2023=E5=B9=B44=E6=9C=882=
7=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:48=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> mcq_mode_ops uses only param_{set,get}_bool(). Therefore, convert
> module_param_cb() to module_param() and remove the mcq_mode_ops.
>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
