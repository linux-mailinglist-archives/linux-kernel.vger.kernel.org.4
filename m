Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ED96C0A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCTGUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCTGUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:20:47 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0C7C646
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:20:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ja10so11375628plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679293246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPw1aq0QjTgBTki7NjgMvgDoXxaJ95IR1hFLPYWhd+w=;
        b=AwL0laUVjYeqTC3RqjeRLaH81efCtRGmrjT71+7rJRogyZR1KS8rfNZjdoHkYrYZhy
         BvSOJVcY9Sb+kqwsqKYPHqlCReTAMxrFpkp9ZWa7Dfz4N3X0kO7b5hrWQO30Tt1JMzDV
         yuzZIesJruzAvdFmo/4VZGWBq1gwPDFO3cP2Oil7xAxLMC5nwFSIe4ty9r7DmnzUpQl4
         PnG3IZtpU8n22IHR7QRHublm95XumcSmsM+RnCEBkMfHYp9dfDsUHsFmFzS2V2JPvZQm
         +NOikiD/S4fZHleSpgf+c5pWkENYj6iWLqqCghE5ddLfj8ToifvCxby9bLVTPdt5qJoo
         bAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679293246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPw1aq0QjTgBTki7NjgMvgDoXxaJ95IR1hFLPYWhd+w=;
        b=DkSrn+XmKd8MDyf4aarVj8h79Tlcv1gJ+HqI6nbegjzQKTDvF3wthRbvf9YxnM+1Qx
         OcGhc93YEVBThL1/52NlJ4ds8ukm47Et0ME3pF7n2iSnt7Dql5Vh7HOenZ92Qshd7DNE
         YpNuA5sMeLK6qpVO+1RgjpeYrMJjeNMutIUJAXkmlD1UibCbaJiGWTfrliEdRKTQBDxo
         bYwNrEbYAlDcrBw0hPoTGjRbvpYsipAVJGCUQB5e+x3dwvq1n32TiEM8pCA1Gwx5nudK
         yO+YbMgsrI9gZe5D+yHT00D9yWx/JxQBlpSC5E6oqwTUUNcPEx0zbdfYQgW3xtqcUCUa
         B1Rg==
X-Gm-Message-State: AO0yUKVr/t4GMWLT7ddb/9Rkma6RNAjH0NBrV3kekrhMF1Sf0A7SaeQB
        3p6UMefvKDq5ds6DQc8B6kDCrEwWsUnEnbL41b8=
X-Google-Smtp-Source: AK7set/mXfRkG7aQIPSvOo0VukP3QBTwGWfLvotTux9/SlnYhi09Ssmv1YJC+EGM+zeHnyw5ntEtIEySyftHxoDHbg4=
X-Received: by 2002:a17:903:2344:b0:1a0:561c:7276 with SMTP id
 c4-20020a170903234400b001a0561c7276mr6357569plh.1.1679293245834; Sun, 19 Mar
 2023 23:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230314075345.1325187-1-suagrfillet@gmail.com>
 <20230316092910.doolw3xiuwwakile@bogus> <CAAYs2=gaTkA2f65SXkexxAUkSPxgaPNQGdkSKS4pYmJ3hO7z-Q@mail.gmail.com>
 <20230316145045.if3iw5qdtfjyroea@bogus>
In-Reply-To: <20230316145045.if3iw5qdtfjyroea@bogus>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Mon, 20 Mar 2023 06:20:34 +0000
Message-ID: <CAAYs2=gtgcKthFyb=Vz6VJZamyfedoXJRXfsrAtLzj0-d=D89w@mail.gmail.com>
Subject: Re: [PATCH V2] arch_topology: Clear LLC sibling when cacheinfo teardown
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        conor.dooley@microchip.com, ionela.voinescu@arm.com,
        Pierre.Gondois@arm.com, linux-kernel@vger.kernel.org
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

Sudeep Holla <sudeep.holla@arm.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8816=E6=
=97=A5=E5=91=A8=E5=9B=9B 14:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Mar 16, 2023 at 10:30:52AM +0000, Song Shuai wrote:
> > Sudeep Holla <sudeep.holla@arm.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8816=
=E6=97=A5=E5=91=A8=E5=9B=9B 09:29=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Mar 14, 2023 at 03:53:45PM +0800, Song Shuai wrote:
> > > > The teardown of CPUHP_AP_BASE_CACHEINFO_ONLINE now only invokes
> > > > free_cache_attributes() to clear share_cpu_map of cacheinfo list.
> > > > At the same time, clearing cpu_topology[].llc_sibling is
> > > > called quite late at the teardown code in hotplug STARTING section.
> > > >
> > > > To avoid the incorrect LLC sibling masks generated, move its cleari=
ng
> > > > right after free_cache_attributes().
> > > >
> > >
> > > Technically in terms of flow/timing this is correct. However I would =
like
> > > to know if you are seeing any issues without this change ?
> > >
> > > Technically, if a cpu is hotplugged out, the cacheinfo is reset first
> > > and then the topology. Until the cpu is removes, the LLC info in the
> > > topology is still valid. Also I am not sure if anything gets schedule=
d
> > > and this LLC info is utilised once the teardown of CPUHP_AP_BASE_CACH=
EINFO_ONLINE
> > > has started.
> >
> > There is no visible issue in the entire offline process(eg: echo 0 > on=
line).
> >
> > However, when I hotplugged out the CPU into the state before CACHEINFO_=
ONLINE on
> > my kernel with the CONFIG_CPU_HOTPLUG_STATE_CONTROL configured,
> > the share_cpu_map had been updated but llc_sibling had not, which
> > would result in a trivial issue:
> >
> > At the end of stepped hotplugging out, the cpuset_hotplug_work would
> > be flushed and then sched domain would be rebuilt
> > where the **cpu_coregroup_mask** in sched_domain_topology got
> > incorrect llc_sibling, but the result of rebuilding was correct due
> > to the protection of cpu_active_mask.
> >
>
> Wait, I would like to disagree there. While I agree there is inconsistenc=
y
> between cacheinfo cpu_shared_map and the llc_sibling in the tear down pat=
h,
> it is still correct and terming it as "incorrect" llc_sibling is wrong.
> The cpu is not yet completely offline yet and hence the llc_sibling
> represents all the cpus it shares LLC. When the cpu is offlined, the
> cpu_topology is anyway removed. So I don't see it as an issue at all.
> If you follow __cpu_disable()->remove_cpu_topology(), it gets updated the=
re.
> If the sched_domain_topology is not rebuilt after that, then we may have
> other issues. What am I missing ?
>
> I am not bothered by cacheinfo cpu_shared_map and cpu_topology llc_siblin=
g
> mismatch for short window during the teardown as technically until the cp=
u
> is torndown, it is sharing llc with llc_sibling and it is definitely not
> wrong to have it in there.
>
> > The stepped hotplugging may not be used in the production environment,
> > but the issue existed.
>
> What issue ? If it is just inconsistency, then I am fine to ignore. That
> is just artificial and momentary and it impacts nothing.

My original point is to clear the llc_sibling right after clearing of
share_cpu_map
like what you did in 3fcbf1c77d08.

And the ~~issue~~ I described above was found when I manually tested
the 'base/cacheinfo:online' hpstate,
which can be triggered by the following commands:

```
hpid=3D$(sed -n '/cacheinfo/s/:.*//p' /sys/devices/system/cpu/hotplug/state=
s)
echo $((hpid-1)) > /sys/devices/system/cpu/cpu2/hotplug/target

```

Anyway, the short inconsistency window you explained seems acceptable to me=
.

>
> > Even in the entire offline process, it's possible that a future user
> > gets wrong the llc_sibling when accessing it concurrently or right
> > after the teardown of CACHEINFO_ONLINE.
>
> As I said, even if someone access it, it is not wrong information.
>
> --
> Regards,
> Sudeep



--=20
Thanks,
Song
