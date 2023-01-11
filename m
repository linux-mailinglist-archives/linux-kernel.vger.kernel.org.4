Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92A066590E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjAKKcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjAKKbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:31:51 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826B510EE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:31:50 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y1so16337610plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbCjuNspk1al6KyeSMCpiDYLocT3y4oyShnLOrnIobk=;
        b=SA/AnQngW28uW8cyiy4bkf6Q9VLPOl9WDrVT6zxefMD7erV8WWM+RVtbMGT8dghZ5E
         rrqcUYDtIq08v47pSJ81Rb8XUgBm5mDRhZf6bUNxdKD59d8FarS2JpXBfkxBuZb/RrFq
         /CXmrOoGmK4CfGR0mkKamPrwfLsohcRx4kuqRVtiRg8+k7MhGkZxkMLoNRscY4ICPnl+
         RM4H4SBnbVbRC9/CJOAE5t4PkIxR5JzF3uI0hTkpMnteyQJb37kop+CnPjm3WUmkvoxc
         23ijpbxAAvBWinQBzMDr0G6tjD3rPnNWelCrz6Kzc/ov4sDyCB79oFuFM/b+qyZysEgN
         cDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbCjuNspk1al6KyeSMCpiDYLocT3y4oyShnLOrnIobk=;
        b=NqYTgQYw1WqQ5XEV+3YfTUxJK2IP72TNNZ1bh/uUa9XvkAq8LQ3EXFBwDUYtYeRuok
         zgwqQ9OYDk1ACsVsMlpDtJeRGnsT6+knvO0rvW5xfvq0m8T9Q0nJpEerr0EoeMehUT+L
         r4R2rg3HBTRURWYvGfzpUJjBr0kQKlbe8sJTCLavO4RVI6TFhUSrpPl+w6nD/YdfwZYf
         DakxF1G6MnrLEivq6SpsJqnPOpE2UNn/Bn1ZT3pEx5t6ug8Y4lUqvi/fI2X8oauuc+uI
         k1XP6dgc8xO6pacrrwp7EHS4ypCXKGXF/d+lZDalbBAn7Ntcfab9IIIuwvOl99gNiVuz
         X1eA==
X-Gm-Message-State: AFqh2kpTa6PA6SgB1aURBLmKKN7tUkhbEsP3yoxJn2wh30R4MwU+B3tp
        /GiFVEoJesiNes/1fcHlwqsXNMCgOKLwlD+gq/y8yg==
X-Google-Smtp-Source: AMrXdXtFk5l0il1vA3D+6OgvWOK+kBZNBUEtPjjmJsNLGg++mQ6QqV+817kYVWm+pB94z3yk9jPRVWYAdUEqKa58Kkc=
X-Received: by 2002:a17:903:22c2:b0:189:b4ed:56a1 with SMTP id
 y2-20020a17090322c200b00189b4ed56a1mr4345123plg.62.1673433110105; Wed, 11 Jan
 2023 02:31:50 -0800 (PST)
MIME-Version: 1.0
References: <20230111064842.5322-1-anand@edgeble.ai> <20230111064842.5322-3-anand@edgeble.ai>
 <7148963.18pcnM708K@diego>
In-Reply-To: <7148963.18pcnM708K@diego>
From:   Anand Moon <anand@edgeble.ai>
Date:   Wed, 11 Jan 2023 16:01:40 +0530
Message-ID: <CACF1qnd=o+QWuofgAb+YXOs1R_dOuCPxWrb-+YEhuN4z8OnTrA@mail.gmail.com>
Subject: Re: [PATCHv4 linux-next 3/4] Rockchip RV1126 has GMAC 10/100/1000M
 ethernet controller
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Thanks for your review comments.

On Wed, 11 Jan 2023 at 15:41, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Mittwoch, 11. Januar 2023, 07:48:38 CET schrieb Anand Moon:
> > Add Ethernet GMAC node for RV1126 SoC.
> >
> > Signed-off-by: Anand Moon <anand@edgeble.ai>
> > Signed-off-by: Jagan Teki <jagan@edgeble.ai>
>
> patches 2-4 have this Signed-off-by from Jagan again where he is not
> not the author but also not the sender.

We both work to fix this patch hence Jagan's SoB was added.
>
> Also this patch here, needs a fixed subject with the correct prefixes.
>
Ok, will fix this in the next version.
>
> Heiko
>
> > ---
> > v4: sort the node as reg adds. update the commit message.
> > v3: drop the gmac_clkin_m0 & gmac_clkin_m1 fix clock node which are not
> >     used, Add SoB of Jagan Teki.
> > v2: drop SoB of Jagan Teki.

Thanks
-Anand
