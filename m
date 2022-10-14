Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA05C5FE71C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJNCpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJNCpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:45:04 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6870422E8;
        Thu, 13 Oct 2022 19:45:02 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id h3so3648087vsa.4;
        Thu, 13 Oct 2022 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbEsSwm1qOqlPn0HC5WClXMW5nRm6+V3m8gYZXhzjag=;
        b=VUGv4p8kT7+JUns6CWnsUrloNXRwoXP2m1mMz+vv3hnhCkYdIrleC0h+/iKFVIboAf
         FtJHX75hkhBR0XSsZDFwEZ95N7VMYIAXx0s3DmZIhpY5721rBiZ5LTFzmVs0XHfRL9zD
         CRU1HUiiMt8EXryIjiC3KX+p2ZQlSJRu/0VJvJpC0Xp9OORG7kBqRibVOLCf5OIh8Xrw
         4fvhUyCBGDQTnCdngkyLsOEoNXMIJywfz9UCF2K1tYJRmqpy7BaYyLqgEOnLFbHLOkif
         7w3kAtIQtq5ByoSKgNRaEuberyJ7nz4LFaiIsdTXSmI17EmWuSqJxnAua7QUGgoHxGEm
         zXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbEsSwm1qOqlPn0HC5WClXMW5nRm6+V3m8gYZXhzjag=;
        b=2/T8SZ+5WxAgAQXFlg4uNb/AnEWvYmNbbcpgBj0JiWGyPkxvNjT9Z1K0TVWdu1uDlC
         GhdiJUhLsHxpBPH7UH5XZMqpgY0nyPaoFn2LW/j6YTaTm4JLr9rofoLjMjlFAemSQUF8
         2OqRcVZnZ51r5TtoT8bLr5rmO9P6lHCN9vLjKfCqtEUKdcbixPmTMA5IUngWb0eChqGb
         2NSEatvacVzDBVrLu3sXkXwDhC8ysVvuF/xCy7bXhfBOYO71dnDI0tlbc+hDVnwcnR/v
         kl8C8vQqFx5QYEJJF67MULRmm0MDF88BKWwG+HIfYLKNS6mxcbAdq0IAWfQVUUUqQO+u
         W8zA==
X-Gm-Message-State: ACrzQf3a8/13BH7s8t4FUPN2u/f4Ae3EyvzuOXGviczG50D8fie2/jlv
        u5H6p2dGC6//uA2FNgSjT7B1wpqmkdqGMrBTiXs=
X-Google-Smtp-Source: AMsMyM5NUbfa3Q16+pHwp3Nlwf3OP2qK/KougWek0CkvCdZbLZ4B8MzKb1oTARrSnBRPUsoUiDomUgE95yPtwCuEr+k=
X-Received: by 2002:a67:d29b:0:b0:3a6:ead0:42a1 with SMTP id
 z27-20020a67d29b000000b003a6ead042a1mr1590736vsi.12.1665715501797; Thu, 13
 Oct 2022 19:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221011021653.27277-1-gaoyankaigeren@gmail.com>
 <DM6PR04MB6575AE77585D584652179089FC239@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAFN68yVajOkV++gCp-y1+SD5VOKLgUeBhfgskrJZOX5dfGi07A@mail.gmail.com> <bee1807b7d072b221c44ac8c2ed8064939d33696.camel@gmail.com>
In-Reply-To: <bee1807b7d072b221c44ac8c2ed8064939d33696.camel@gmail.com>
From:   =?UTF-8?B?6auY5Lil5Yev?= <gaoyankaigeren@gmail.com>
Date:   Fri, 14 Oct 2022 10:44:50 +0800
Message-ID: <CAFN68yVdwrECaDvNuok_4V-54UZUJU9+dn5icaiPdj6BXEZuVA@mail.gmail.com>
Subject: Re: [PATCH] ufs: core: Disable auto h8 before ssu
To:     Bean Huo <huobean@gmail.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Bean
we can choose one of two h8 for sure, and we chosed auto h8 during sys acti=
ve.
when ufs suspend/resume, ufshcd_link_state_transtion will send DME h8
enter/exit always.
that's why the above sequence show up.
" UFSHCI has idle time before bringing Link into hibern8 mode, " I
think  ufs put the link to h8 during the time

Bean Huo <huobean@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=B8=89 22:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 2022-10-11 at 19:53 +0800, =E9=AB=98=E4=B8=A5=E5=87=AF wrote:
> > Dear Avri
> >   Unisoc reports resume fail on UFS(micron FS164) during
> > suspend/resume test.
> >   We check host inserts auto H8 enter/exit event between SSU sleep
> > command and H8 enter command in runtime suspend .
> >   Asfollows: SSU Sleep command --> auto H8 enter --> auto H8 exit -->
> > H8 enter --> idle 2ms --> VCC off.
> >   However device AQL FW can=E2=80=99t enter LPM within 2ms after second=
 H8
> > enter command.
> >   FW already enter LPM after receive auto H8 enter command , Next
> > auto
> > H8 exit command will trigger FW exit from LPM, it need take over
> > 10ms,
> > and FW can=E2=80=99t enter
> >   LPM again after second H8 enter command until device complete exit
> > from LPM. So disable auto h8 before ssu is a reasonable solution to
> > solve it.
> >   Hynix also has similar request.
>
>
> Hi gaoyan,
>
> The above sequence confuses me. UFSHCI has idle time before bringing
> Link into hibern8 mode, do you know what the settings are?
>
> Also, if auto-hibern8 is supported, in this case, the host-side SW
> should not send manual hibern8. If this is an issue to all UFS or
> UFSHCI, we should disable manual hibern8 if auto-hibern8 is enabled. or
> let customer to choose one of two.
>
>
> Kind regards,
> Bean
