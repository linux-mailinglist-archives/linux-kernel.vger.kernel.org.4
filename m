Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FDB68A227
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjBCSnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCSnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:43:24 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A501F482
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 10:43:22 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qw12so17891526ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 10:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WYHLXhuxGYBGKT2EIEEZuysVzO3RUeMxA6JroMGLpQ0=;
        b=no2l+QBUZFFs88G/oFYENQ49X9coNvMXEA87fMc2yboJGjWAVDgzu/Ut9nqW/TxTEs
         1DMWhU/HOMrtdXFkp5xe6P7lY7KeDQ13zWE4bOuRwrMSAdDjbK4jqD8gq4Ajk2KkVAlO
         RjQWpFaK4WMpkZgFx8sYSb/wAu3CXB1Ts4czroSfgccPlOKUYnqil/niCDvzOjkt9gcx
         LWRxnqYji+qS50k41d/l9JLupQYMUIbE43OtWu4NSEuBOgNkNMLAMZQj7avbsT9RHLsR
         zKoPLKrSnSFKh+gIBhxm1y9jfh1Ux6l0V50abYKboIMmQEUZPLVcC281U5ApRQYl5zid
         7ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYHLXhuxGYBGKT2EIEEZuysVzO3RUeMxA6JroMGLpQ0=;
        b=PlQALX3w5h4eXTMajXxqYtiMZY18CBZ57QBgacZ0Up9s6LcvwYtadrv5zROxjNy7yB
         3hIkq77duTf8FbYveyel9TbZDW2bMyXaMlwogi+xm7JIU6+sSx4UU+D3bG2HOYeoTxtW
         8o1vGty9tdqaQfhjtw1AZZQMjRXI/R2fH+WyNapa1gOvJ5bdVBLWunCJstoUkHGFoaRd
         jx32Q7MO/9YLY6tNzIPvHqrC8O7xSUKxI8FW0qwRlUQEYeU4iFLMNzJxBk0jHnrn2NvE
         BI55vS6HKFmuH51GI0hECOHRMqiL8KVnVMaQkHY0F+7/yp7jYjh0pq7qfa+ulgiDteIT
         5DGg==
X-Gm-Message-State: AO0yUKWSSEsOHSmZYdzK7ttn7pWPBZIOtG3PVsheADWCpn0Y3sUG2rU5
        VB3rOsTzSepwnvQSVDZ3rtWDXcI72BSDqln2JRoLRg==
X-Google-Smtp-Source: AK7set/Js5fkpiAlA1jZ2GqAUGZ8/7XK+oZjw7kzCdSdI+EadWnNZFqAzFQtPvaQ5ThAQF5F1GYRC65B1AvQS+aNCYI=
X-Received: by 2002:a17:906:e09:b0:871:7a08:9d6e with SMTP id
 l9-20020a1709060e0900b008717a089d6emr3805890eji.234.1675449801327; Fri, 03
 Feb 2023 10:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20230130094157.1082712-1-etienne.carriere@linaro.org>
 <20230130094157.1082712-2-etienne.carriere@linaro.org> <Y90b6kxAtbookjty@pluto>
 <20230203170448.v5iduw2rhpxc47f3@bogus>
In-Reply-To: <20230203170448.v5iduw2rhpxc47f3@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 3 Feb 2023 19:43:10 +0100
Message-ID: <CAN5uoS9=Hu+q+9Poei3OAiF2hOD3JtN5Ny4ejUrW2j18TZKSug@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: arm_scmi: optee: use optee system invocation
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sudeep,

On Fri, 3 Feb 2023 at 18:04, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Feb 03, 2023 at 02:36:26PM +0000, Cristian Marussi wrote:
> > On Mon, Jan 30, 2023 at 10:41:57AM +0100, Etienne Carriere wrote:
> > > Changes SCMI optee transport to enable sys_service capability of
> > > its tee context to leverage provisioned system resources in OP-TEE
> > > preventing possible deadlock.
> > >
> > > Such deadlock could happen when many Linux clients invoke OP-TEE are
> > > are all suspended waiting for an OP-TEE RPC request access an SCMI
> > > resource through the SCMI OP-TEE PTA service.
> > >
> > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > ---
> > >  drivers/firmware/arm_scmi/optee.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> > > index 2a7aeab40e54..91840345e946 100644
> > > --- a/drivers/firmware/arm_scmi/optee.c
> > > +++ b/drivers/firmware/arm_scmi/optee.c
> > > @@ -559,6 +559,9 @@ static int scmi_optee_service_probe(struct device *dev)
> > >     if (IS_ERR(tee_ctx))
> > >             return -ENODEV;
> > >
> > > +   /* SCMI agent can used TEE system service resources */
> > > +   tee_ctx->sys_service = true;
> > > +
> > >     agent = devm_kzalloc(dev, sizeof(*agent), GFP_KERNEL);
> > >     if (!agent) {
> > >             ret = -ENOMEM;
> >
> > LGTM.
> >
> > I suppose you'll sync-up with Sudeep for how to queue this whole series.
> >
>
> I thought I had responded to this but not. Anyways since TEE changes are
> significant than SCMI, you can route it via TEE tree. In that case,
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Let me know if that was not your plan.

That's fine. Thanks. I'll ask Jens to apply it next to the optee commit.

Regards,
Etienne

>
> --
> Regards,
> Sudeep
