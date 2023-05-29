Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4871522B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjE2Wu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjE2Wu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:50:28 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFDD9F;
        Mon, 29 May 2023 15:50:27 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-62614f2eee1so10845646d6.0;
        Mon, 29 May 2023 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685400627; x=1687992627;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVBRt1RRCrWOt+dpsuJxOTx1nUGJsRbKUrCzrpzPHpg=;
        b=SnClQBMxTp7WB5BKdPH6jLBMnPf5Rr57XQye4Tg/qNfGeWa1n6+0eqOQcuMaP2RptJ
         7TKbm0BI28LC/0aa5r1aTz7ACKqd03WMuYRX6Gdh3fOUwo58EzWofQlfs1C/Nsymc6YB
         c6FljdFLU6htyUlDU3cDgXZaLY05vZ2PZLXLCXkkWZpYX51iOFbdmkV93z4kUlZTd7sv
         okUF6FFd5LQd75En8avR1si/y/Ot4/tgWQHudIRv2wpc7DH8fsrRQFyEqD60JD6Yila4
         ccE8kSERvSJJMZ2sN3sE9j47sTHDrPii5Lf2dGarVCJ3pEedbfuznbV+u2p6ed46QE8e
         /q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685400627; x=1687992627;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RVBRt1RRCrWOt+dpsuJxOTx1nUGJsRbKUrCzrpzPHpg=;
        b=KHF+vWs4Pr7zU9QoF3DHIrRfs6yq0DB6zg8cT/i+HoLgJNMIpp07ILwdwmRSNLR7ML
         ikqKdVJR0z317Op6v2q6IBB8G8pMXCBKQeZ1LOCvcr7RCrinSFFLlDPBTDtZov6ld113
         s7DKFeUdQIDvbC8E7mjw1CVPI8f4700jBcIvngYOIJxhDwx3BRYkeugyOI3omTBfLAvD
         fvVMGlQ+WYu7D/N2usTWW04doZ1JHA22sazEKESVyB3u0qQXQWC2A5tEO2Aj9uryWlxN
         cFeY/r/KGig5iaBzPmvCwaWKX3Nbj31PyflQoxWkp5zKFR2l4BPSDSeBdEwGxbWecZvJ
         NbUQ==
X-Gm-Message-State: AC+VfDykt+7crMwqgOvJEihi2BdzbovhgjKtt1Dg2BVt4plgjGQa3qCi
        uSq1FzKgUIJDwK0Bxs1MOuQ=
X-Google-Smtp-Source: ACHHUZ5RCCEHDMQYUZGVjcK+yOtF4rKDjrLpwjulFacPlB4NJo4QrqTLdOvIxYIYnMkqqrmoK4HEKg==
X-Received: by 2002:a05:6214:c24:b0:625:aa1a:937f with SMTP id a4-20020a0562140c2400b00625aa1a937fmr186250qvd.59.1685400626774;
        Mon, 29 May 2023 15:50:26 -0700 (PDT)
Received: from localhost ([2600:4040:2007:9800:1794:1f51:786e:6197])
        by smtp.gmail.com with ESMTPSA id p8-20020a0cfd88000000b0062439f05b87sm4121831qvr.45.2023.05.29.15.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 15:50:26 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 29 May 2023 18:50:25 -0400
Message-Id: <CSZ4NQFL3URD.I9QE8Q3018KI@Latitude-E6420>
Cc:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, "Olof Johansson" <olof@lixom.net>,
        <soc@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: qcom: Add Samsung Galaxy
 Express
From:   "Rudraksha Gupta" <guptarud@gmail.com>
To:     "Conor Dooley" <conor@kernel.org>
X-Mailer: aerc 0.8.2
References: <20230527040905.stmnoshkdqgiaex6@ripper>
 <20230528001010.47868-2-guptarud@gmail.com>
 <20230528-decode-creasing-f5b3996163e5@spud>
 <ad7a6ee3-cabb-6f92-a595-8791801cfe97@gmail.com>
 <a8d3d68d-d202-ddba-3289-65b347807538@linaro.org>
 <CSZ46N3I9GM7.NON5KMJ66OK5@Latitude-E6420>
 <20230529-bonsai-during-37a47a528ff3@spud>
In-Reply-To: <20230529-bonsai-during-37a47a528ff3@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon May 29, 2023 at 6:37 PM EDT, Conor Dooley wrote:
> On Mon, May 29, 2023 at 06:28:05PM -0400, Rudraksha Gupta wrote:
>
> > Gotcha, I will do that next time. Should I still send v2 in a separate
> > thread?
>
> That'd then be either [PATCH v3], or [RESEND PATCH v2]. Ideally v3 since
> you will have added the tags you received on v2.
> AFAIK Bjorn uses b4, which should be able to deal with the series as-is,
> but sending a v3 with the Acks etc would not be a bad idea. You
> should probably give it a couple days before doing that to see if it
> gets picked up before doing that.
>
> > Not sure if I should as I don't want to spam anyone.
>
> Sending new revisions of patches as a new thread is not spamming, we
> signed up to be maintainers, or get to email from the lists, after all.
> Sending several revisions of the same patches in a day would be spamming
> though, but that is not what we are talking about here ;)
>
> Cheers,
> Conor.

Ah, I see. Thank you for being patient with me. I'm really excited to see m=
y
patch go in! :)
