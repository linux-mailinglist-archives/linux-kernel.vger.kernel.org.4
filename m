Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208F97501FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGLIt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGLIt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:49:26 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09365EA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:49:24 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-765a4ff26cdso622908085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689151763; x=1691743763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6asCIJZfh89X/Pid3ai0oXZDotleMvJEDvS2yZNbiic=;
        b=BVmcnc4SJ4NNyAlLwbkYhFQsxpIE/2gt8dFBgtENtVwmo5KP/TuO9o+JVHkuWbAqRV
         rkOvgo+eB6VMX8332YE21U4AXOR1NPYhs/HJOrvrNl6zZtKqi82E0dIV8zuA9NWnEqJu
         1hlqBFuGx+tz8rmEG8cH77x8GEntkyjJX0qrV5Y9pJyxsPjpASMAJ7MHukrFv9TTa85W
         dOM+QqJSMSUf3LJozf/rjD/aOQFYdmK/16ZW9MyNLbjQWxh80tKUB81SFmTdWzDzAG0E
         3ilJ/ic+HknUn8rbAaMJQozGahvbyponRv0CfVi2dLsL7P2HEdqCdQCAwT/q+hTX0J+V
         hEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689151763; x=1691743763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6asCIJZfh89X/Pid3ai0oXZDotleMvJEDvS2yZNbiic=;
        b=NlrNwzaAJmOUas8bNEswiur/5Vf8zuf05AbpzMiNq5vLCHrooJ0goP9N8PBxD6Cqab
         5VCLxKU+s84dU0l+hXVENNx4jHbJocYjC2zTBV1gH6zyA1epQid4dZlb29Z4z4TPA5yX
         L9DbrH+G9mMcEgmLf1P5qfS87wMbFLyRx96XRGK3QF4jC0lUXYFPMh8VO9MRxpRg+6VD
         7aqR0ENAeyE8sAArf9v34vWrygnoWx9An7SAqpPAZLmuecjd5SD4ZoS+Ca3os+WkOXAV
         NVSsEvz9p56T/NIxwfx90FRuD5aYacLx05qbyYkLxbEoBFx0SXPxZQiRpgKp7UWOj2Sq
         5IDw==
X-Gm-Message-State: ABy/qLaFszgNwbsBlNcBRpKBGQOghXnABhpRmcQQqf8lOqPThv7FJhfx
        zCfm27fP3mSHxEbBx/kjo8/2oU1b/GItrqHJIwr9BAFJnJzCr/fRpnM=
X-Google-Smtp-Source: APBJJlF72vy+DxMvN0aXWMy3infWehyApUye86ZMGblUGpIBDBNTDFaMkN4MymHVU2YOFBQEcRz7PWbxFRxdfoCgR7U=
X-Received: by 2002:ae9:d613:0:b0:765:381a:3487 with SMTP id
 r19-20020ae9d613000000b00765381a3487mr17442349qkk.57.1689151763171; Wed, 12
 Jul 2023 01:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230711160452.818914-1-Naresh.Solanki@9elements.com> <36752432-52e7-22e1-a2de-332749aa15a1@roeck-us.net>
In-Reply-To: <36752432-52e7-22e1-a2de-332749aa15a1@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Wed, 12 Jul 2023 10:49:11 +0200
Message-ID: <CABqG17gswZCgtc7ECZK=AJ8S3=QRQ_HW2ZmS=cLUSrq=63qOSQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] peci: Add Intel Sapphire Rapids support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        iwona.winiarska@intel.com, jdelvare@suse.com,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Tue, 11 Jul 2023 at 21:46, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/11/23 09:04, Naresh Solanki wrote:
> > Add support for detection of Intel Sapphire Rapids processor based on
> > CPU family & model.
> >
> > Sapphire Rapids Xeon processors with the family set to 6 and the
> > model set to INTEL_FAM6_SAPPHIRERAPIDS_X. The data field for this entry
> > is "spr".
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>
> Please version your patches and provide change logs.
Yes, I missed that. Will be updated in the next patchset.
>
> Guenter
>
> > ---
> >   drivers/peci/cpu.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
> > index de4a7b3e5966..3668a908d259 100644
> > --- a/drivers/peci/cpu.c
> > +++ b/drivers/peci/cpu.c
> > @@ -318,6 +318,11 @@ static const struct peci_device_id peci_cpu_device_ids[] = {
> >               .model  = INTEL_FAM6_ICELAKE_X,
> >               .data   = "icx",
> >       },
> > +     { /* Sapphire Rapids Xeon */
> > +             .family = 6,
> > +             .model  = INTEL_FAM6_SAPPHIRERAPIDS_X,
> > +             .data   = "spr",
> > +     },
> >       { /* Icelake Xeon D */
> >               .family = 6,
> >               .model  = INTEL_FAM6_ICELAKE_D,
> >
> > base-commit: 4dbbaf8fbdbd13adc80731b2452257857e4c2d8b
>

Regards,
Naresh
