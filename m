Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80E26DE902
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDLBgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDLBgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CD840FB;
        Tue, 11 Apr 2023 18:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DC3C6258E;
        Wed, 12 Apr 2023 01:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA09C433D2;
        Wed, 12 Apr 2023 01:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681263402;
        bh=hSiZ8aa9oBm0phs5wcakiPja02QuQvZtXKOyCGBRUuM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wx2MgFeLhGwcKDRT5s9VkUKtmtRzufPoV/x0zumGk3pRNh5t+4asIZsoVEhlSUVnj
         hH8BaNL7yxeU2lPAyMOokhNr3JJq42NVoDsQxQRYqocWLnS3ABm0zPqllz7NWGo+m0
         EQvJ/b3KPADNuCFRVYh+NxrlU4CuI9X3cb68WAh2cCgQgAq8pjbo2wY9lRX5FPiU6i
         rOKQetHX/qX1C/u0oskxroBmEpYUIfgA9GFkeKO7ceOOH0L07+qAO11GpoNEUpZWKj
         lRtYI6xZyu2WI2FRncdJ4IXOs/izFkHs+aPWxrPMtPYZONA/3wlUF4aMp4veaB4Bdu
         3V1eN1p/q/TqA==
Received: by mail-ej1-f44.google.com with SMTP id j17so15329033ejs.5;
        Tue, 11 Apr 2023 18:36:42 -0700 (PDT)
X-Gm-Message-State: AAQBX9ca0Kiq43wcpki8kePdR2cDtFGLq/QjXbrY0g/IgTQEENsyrARR
        oepEkFiZx9b0ez6k5HYat1QHYTaNAiu8jd3C1mc=
X-Google-Smtp-Source: AKy350bfAWR/ZRYMtJP92OTQLgG3LvrYvF1QxL3h4BK9QlDcZowG3gUqT1D4txtlajhHAnW7Xt8ozP7m8WZ+9XparZo=
X-Received: by 2002:a17:907:2147:b0:94a:597f:30ee with SMTP id
 rk7-20020a170907214700b0094a597f30eemr4863056ejb.15.1681263400987; Tue, 11
 Apr 2023 18:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230411072741.3ac89dfb@canb.auug.org.au>
In-Reply-To: <20230411072741.3ac89dfb@canb.auug.org.au>
From:   Shawn Guo <shawnguo@kernel.org>
Date:   Wed, 12 Apr 2023 09:36:29 +0800
X-Gmail-Original-Message-ID: <CAJBJ56JP7QcNnJDEaSohMMD81NnS-88WDiDZtwkuXNSZPATpKQ@mail.gmail.com>
Message-ID: <CAJBJ56JP7QcNnJDEaSohMMD81NnS-88WDiDZtwkuXNSZPATpKQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the imx-mxs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 5:27=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Commit
>
>   3a6f4dc2c8cf ("dt-bindings: vendor-prefixes: add chargebyte")
>
> is missing a Signed-off-by from its committer.

Fixed, thanks for reporting!

Shawn
