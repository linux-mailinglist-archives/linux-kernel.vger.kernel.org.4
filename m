Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C50A74D775
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjGJNYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGJNYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:24:52 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE82DD7;
        Mon, 10 Jul 2023 06:24:46 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b867acbf6dso3309489a34.0;
        Mon, 10 Jul 2023 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688995486; x=1691587486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez1T/Q5iWSzUDGh47qmMHdqY+oaUaEYSNPMGMd9EKWw=;
        b=sUqVZGffbok0LO+PHa3nbFV2uPQRcnt8uZ1PsyHI4hVoLuBLvSdBzL41JvlQQBe0km
         5myyTQgquFl/OZt2fsbsQI0bUgp/e2UxgmHW9bNETONsbwrjVC1aE7K3gLI9fRiql2VR
         2+z1MeHQ+nIgnHc6tPxsyWMpls49G5NruJApUWhtK6namhOKvUx1fmR2u/QUg9cb6qIh
         lJrZM9A409zEl3FnjdVgCUwmeUKb4378468nuw1oUskaY5cebmjYAFeBKWwuRexv3qoy
         WHcM1MjfsrFkTUND3cS6PAbU+t4R5MvKIc3YdQegmHXdZxWkgMi4MWx+q4CJtEm4PfVo
         o1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688995486; x=1691587486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ez1T/Q5iWSzUDGh47qmMHdqY+oaUaEYSNPMGMd9EKWw=;
        b=IPQAQfpc7RZF7msdw6sOHnhdq+dzJkOmbvkOu2/pFYsBRNTvcvPYRpWepqmF2khynn
         Q9IOanouQkD5jt95+LNCgzC0HrGbieR1ctmGxkt28YSUrCDp5OcIeebZrxB9HW1AXQn/
         UjlFKDLYDuYEAn8q0bJlcg2w3hQfwWHgaOozNfEHQ4TtIx8uxFvXSXyXahKOf/OsmvnO
         /kNbKRcYNgj9cdqbRZtTUjGL2JgItTPBXeuTti4vViFaP8gWdI6NayqRlxR02U8+Y92p
         4u6MYpHmWXnqz4O3h6O1gskPBY2ECJL8SKOuh6Hm5vkXtvGjK9Vvm/cNMO+b1GeIcU5S
         4Hzw==
X-Gm-Message-State: ABy/qLZ0ymyWLOEUSaxNbkRQc4RtQD0mIW67i9QZhDq0s6W4p4Z+gChw
        I64C0SToTWLNLJz3SkwaSbgOcwpsmniBe3IUDzo=
X-Google-Smtp-Source: APBJJlHPr/+DiaHfauIV3i/AMamxwO40eaZsNOvHXXeTFxAmchFipX8ers4a+nwCgyawizGzwTUMDHk3IASARU3LfLo=
X-Received: by 2002:a05:6808:1587:b0:39f:f42c:863 with SMTP id
 t7-20020a056808158700b0039ff42c0863mr8683535oiw.6.1688995486137; Mon, 10 Jul
 2023 06:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230710082534.762599c8@canb.auug.org.au> <54adffa8-b500-e1b4-7274-9a5354be8cfe@amd.com>
In-Reply-To: <54adffa8-b500-e1b4-7274-9a5354be8cfe@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 Jul 2023 09:24:35 -0400
Message-ID: <CADnq5_PvEKum2Wdmei7Zk8kBe_6NWzv2Oaqg7juPFriPOtRWgg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the amdgpu tree
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Mon, Jul 10, 2023 at 9:21=E2=80=AFAM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
>
>
> On 7/9/2023 6:25 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Commit
> >
> >    aeddb7d13ad3 ("drm/amd/display: Block optimize on consecutive FAMS e=
nables")
> >
> > is missing a Signed-off-by from its author.
> >
>
> Hi Stephen,
>
> Not sure how the tags went missing, but here is the full commit
> (a7d8d8bcbd9af8d4aa1580bffd418af78384040f) information from
> amd-staging-drm-next:
>
>
>      drm/amd/display: Block optimize on consecutive FAMS enables
>
>      [WHY]
>      It is possible to commit state multiple times in rapid succession wi=
th
>      FAMS enabled; if each of these commits were to set optimized_require=
d,
>      then the user may see latency.
>
>      [HOW]
>      fw_based_mclk_switching is currently not used in dc->clk_mgr; use it
>      to track whether the current state has FAMS enabled;
>      if it has, then do not disable FAMS in prepare_bandwidth, and do
> not set
>      optimized_required.
>
>      Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>      Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
>      Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>      Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>

I've fixed it up in my tree.

Alex
