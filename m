Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB856C789E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCXHQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjCXHP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:15:57 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30E326853
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:15:39 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3e0965f70ecso394131cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679642139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NStJZFS2Gb6txcjvYhiRXbaz73gXtLsJkraNktzIj+M=;
        b=slsc2orTdb1VUCunzmPASK4nSeDix1sYu5TaJq5kwU65mFCR8X0rNb9YuE2ny+8y2R
         /eo+4SdSntYlFbTiXaEwPShG8LowC41fc5upmDEcINNNipH7WuQfPRkL56nYvu38xnie
         MVuv64uYC/6sEeicN8dKz9HlkGd+aJr5hr60+UzJrMvvOSm2nQkZndND32XCTrYKP0ZI
         rR70PbmebEWnE0Ma87VI0D4C0jtnVI6EIq6bFqL5t+qsqcisWI4mfyB6ncqn7Z6sWEzl
         EwyPX9Nhyp4VidMgyK9YJ8gTFPZJjggC3BdTFjtAqUFAB4frFJJghT1eExM8nhSRkcJF
         CFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NStJZFS2Gb6txcjvYhiRXbaz73gXtLsJkraNktzIj+M=;
        b=MwepK8XEXmz39ZqaLPB2I6w9jVtOyVLJiDtKiyQnb/cj8sHEtGv4uzeE2o3395pPOr
         fRkWyCEa2d7s8GSwHqEpx8XzJ2j14tQivmAUccSnVngjLWKUVqJpMKIRrHgMo5+wMGWs
         12iQEfP86D6LJGgW86tyVrmnY/oog+PK5IAy44M3VCWvDDQsswaNlDJ1QrygtGegHqVL
         mIYrG/ILi+/9ZgzdVXYy2uqHpOTZImZKND+/zVXyvskQpGrBrBxJwC5d4OKhJ7G7fVbn
         5LEdHoYHUcO/2ioH/XLQtYKH/KMmKFSM0yjp9Fn8hi23D24v0L1r84chNXlDv1zioQEi
         EZXw==
X-Gm-Message-State: AO0yUKVbgfMc+3YM9m/HswGpYl4EN1VupTgSLsoL+K25SNQq1j+hOzlJ
        RISidfMaPN8AEGkFj3gmuwP83l2wqAOqUUtZQTaOrg==
X-Google-Smtp-Source: AK7set+/2UJan9SLGGi7Ef+sZwTZ+aksfDb9pKaZEb6kZWUrij58g9ICurzl9OlsjNwWH5D22OYmJzASauXiFnC7f4w=
X-Received: by 2002:ac8:7f41:0:b0:3d3:3cc:6f70 with SMTP id
 g1-20020ac87f41000000b003d303cc6f70mr157028qtk.17.1679642138794; Fri, 24 Mar
 2023 00:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230323192028.135759-1-irogers@google.com> <20230323192028.135759-9-irogers@google.com>
 <44476adc-3797-504b-2b82-8ec670c691b6@linux.intel.com> <641cba052d0f8_1b98bb294ab@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <641cba052d0f8_1b98bb294ab@dwillia2-xfh.jf.intel.com.notmuch>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 24 Mar 2023 00:15:27 -0700
Message-ID: <CAP-5=fX5KaQE+P5X+jBt9uFymkjWbUi_0dgq2w=18jX8vVQ1XQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] perf metrics: Add has_optane literal
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, samantha.alt@intel.com,
        weilin.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 1:44=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Liang, Kan wrote:
> >
> >
> > On 2023-03-23 3:20 p.m., Ian Rogers wrote:
> > > Add literal so that if optane memory isn't installed we can record
> > > fewer events.
> >
> > I think we call it pmem (Persistent Memory) everywhere in the Linux
> > code. Maybe we should use #has_pmem instead?
>
> That makes sense especially because has_optane implies more precision
> than the the check is performing. In general Optane is probably the
> widest deployed NVDIMM type, but this check will succeed with battery
> backed NVDIMMs and emulated PMEM in VMs which I think is perfectly ok
> for making a default event record decision.

Thanks, I'll change this in v3.

Ian
