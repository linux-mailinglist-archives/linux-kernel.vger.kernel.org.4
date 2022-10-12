Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228415FC756
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJLO0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJLOZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:25:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D0DED0A;
        Wed, 12 Oct 2022 07:25:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b2so38358878eja.6;
        Wed, 12 Oct 2022 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ywo9sjefIn96Juo5BZ8AbB7AgyvrswOBWDpdFl0oFUw=;
        b=inDUemQ0kv7qq1Bjuhh2lkZznWqTA2l4GzombHIlTwqosX0q7m3raN+ehOCSiKY8zV
         MYCH/P8Q4Lffr/D+pepZzlg+BBMBaidVCZbLTvTQtuBMbuKIlTjo4NQ71JsbyVrj5oW8
         AO+kuOqo7NNshnQon0px61dxJvRpqYsiQj1xR+QfQrEdnhhptJI320OH4XSB3z3pA10G
         4Vndh/MOPaMA0IXXs28DF6bB4DzAbmQ2METRkzSLlJvfQels+kBIRQTeP+jVDT9VyANe
         H5bFFL2EQ5Bz6wpSn7xi2pH0YmlbzXDVgiQIQon6pRA4VuLB6USC2mavOX/qbH5Gmz7o
         Qm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywo9sjefIn96Juo5BZ8AbB7AgyvrswOBWDpdFl0oFUw=;
        b=gzNf4J0nIPrBPI81xnWelc/b4aQg1Zwo6ty4q9TZH0x0iRmwdDLSLuj6A9R3Ed6dqA
         48MGQ6L5BU7wEM97vozZp0BmoaCAW5X3hcI1U0B5oQZDbfVl1GjS791LhswFzMkQipXm
         waI+L1OOjMuZz9/52kUp3zipJSMYTPdYj4t5TipAstwlknb/LmS24LVVdmzfQSzxk6Mf
         Gq84oqVHU9W+514joS1MyPX4uXouFYR+uHImClg8oKY7i0yCV2O3EOcHqq+JznNM926M
         Uwh3SLZYGVkq1FcsQ02iL7WZ1Wmsmb9NJ9IaPB1gNOLRxLnB/esXQjNqt2XOLbHQmFtz
         TVQA==
X-Gm-Message-State: ACrzQf3FlW/jgSJopkOv4xYSwE2nESPBiuW9KOzPa5JGG6wIYMBGcJ8P
        TqPNYVhkXLqrYzNu6DKykXM=
X-Google-Smtp-Source: AMsMyM4QaZmdN3l/HekMZ55kLeYaK9fCFXFfR73VG+I210r0JA1I72UV+9uFu9cmuCq3k7iUjQE7yg==
X-Received: by 2002:a17:906:cc49:b0:78d:361a:561e with SMTP id mm9-20020a170906cc4900b0078d361a561emr23706683ejb.741.1665584719253;
        Wed, 12 Oct 2022 07:25:19 -0700 (PDT)
Received: from linux.fritz.box (089144213149.atnat0022.highway.a1.net. [89.144.213.149])
        by smtp.googlemail.com with ESMTPSA id kv13-20020a17090778cd00b0077b2b0563f4sm1336981ejc.173.2022.10.12.07.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 07:25:18 -0700 (PDT)
Message-ID: <bee1807b7d072b221c44ac8c2ed8064939d33696.camel@gmail.com>
Subject: Re: [PATCH] ufs: core: Disable auto h8 before ssu
From:   Bean Huo <huobean@gmail.com>
To:     =?UTF-8?Q?=E9=AB=98=E4=B8=A5=E5=87=AF?= <gaoyankaigeren@gmail.com>,
        Avri Altman <Avri.Altman@wdc.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Oct 2022 16:25:17 +0200
In-Reply-To: <CAFN68yVajOkV++gCp-y1+SD5VOKLgUeBhfgskrJZOX5dfGi07A@mail.gmail.com>
References: <20221011021653.27277-1-gaoyankaigeren@gmail.com>
         <DM6PR04MB6575AE77585D584652179089FC239@DM6PR04MB6575.namprd04.prod.outlook.com>
         <CAFN68yVajOkV++gCp-y1+SD5VOKLgUeBhfgskrJZOX5dfGi07A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-11 at 19:53 +0800, =E9=AB=98=E4=B8=A5=E5=87=AF wrote:
> Dear Avri
> =C2=A0 Unisoc reports resume fail on UFS(micron FS164) during
> suspend/resume test.
> =C2=A0 We check host inserts auto H8 enter/exit event between SSU sleep
> command and H8 enter command in runtime suspend .
> =C2=A0 Asfollows: SSU Sleep command --> auto H8 enter --> auto H8 exit --=
>
> H8 enter --> idle 2ms --> VCC off.
> =C2=A0 However device AQL FW can=E2=80=99t enter LPM within 2ms after sec=
ond H8
> enter command.
> =C2=A0 FW already enter LPM after receive auto H8 enter command , Next
> auto
> H8 exit command will trigger FW exit from LPM, it need take over
> 10ms,
> and FW can=E2=80=99t enter
> =C2=A0 LPM again after second H8 enter command until device complete exit
> from LPM. So disable auto h8 before ssu is a reasonable solution to
> solve it.
> =C2=A0 Hynix also has similar request.


Hi gaoyan,

The above sequence confuses me. UFSHCI has idle time before bringing
Link into hibern8 mode, do you know what the settings are?

Also, if auto-hibern8 is supported, in this case, the host-side SW
should not send manual hibern8. If this is an issue to all UFS or
UFSHCI, we should disable manual hibern8 if auto-hibern8 is enabled. or
let customer to choose one of two.


Kind regards,
Bean
