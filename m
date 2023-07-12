Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550F074FC4E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 02:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGLAnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 20:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjGLAnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 20:43:39 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E92D1991
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:43:37 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-403b622101bso75281cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689122616; x=1691714616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5j1TclRi9dWbgY3muvPB5O+orwdh3Igf/+lYCKbWgU=;
        b=PlFjrl/ohe3U/e4RhDPuGG8IZGaUR6uQRnvruhBtQlywy+ddOjpZWhNbn69BAF1nZn
         Y41UhIk08iIVjsuIf3BKIgpS6mQStKBvlipVRYWvsWrvlaJwTbEG22Kg7wdrza8abno/
         e4cJuht2T1929o2aWn1VkjwYvYSUNfsk4fYdrSClWaTqTl9bFWOGh9MCqMDcgg2cC1kS
         SNNLHRYKJR7Wgio4sHgRYhee5igTlEnqv10LE33b41aCiE/CYZRpK+tbbiSyMHsk2BTU
         wtd9KzvIY9gK3QOTMpZ5bsMmMfxk6xNEK4XlNU8rtluLV1hlT7QKED9uzJS1Kk23HLPl
         zAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689122616; x=1691714616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5j1TclRi9dWbgY3muvPB5O+orwdh3Igf/+lYCKbWgU=;
        b=fsc+zT2nYuoM3GKZFQaLlLN/xy9l3S9ExIldbigwWojYo7kBxXWDSXYBHpYKLTGb3l
         IySA4hs2gcFNFhmRMLVBBQgBUzwjuKINEet1zpm5hCPJKIemsqL/PN9dX1whS+c9w5Rj
         9yuIweN4hWNegxPVw4JLo8bVD9X2JJdpB8W/V8BLuFm2xnKjB39HSMBhadpaKpRCLr+z
         zbT0HbrppHJCnnmSmAsdz3pFkAxtHfoOn4pkqudr9IEYgOFYCrgbMUdmMzRDLfdytfy5
         fWkhQJ3Pg6CgdXgqaQ/pqSz1KR1kQBXPZCIiXKH235ZYvdHmKkR9UtZnuzP0dyZeIGp0
         7ziw==
X-Gm-Message-State: ABy/qLaP1odQKw7UfqMMQ+El81grROr0sFUu7fvY5Szb8fQlq820yaxZ
        MiJRfJ5J9gs6kEygVPTU5WhebqPks/qsp+ehJX3Rug==
X-Google-Smtp-Source: APBJJlEc0448HkICVVj+dxV3oqMjlDKH+nOGnCBRnZKvv3q63RQ7KCMe0IL55ahFJrVTdd9MwsIFwCqnGH07SdHba5s=
X-Received: by 2002:ac8:7f11:0:b0:3f6:97b4:1a4d with SMTP id
 f17-20020ac87f11000000b003f697b41a4dmr55390qtk.23.1689122616472; Tue, 11 Jul
 2023 17:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230711100218.1651995-1-james.clark@arm.com> <20230711100218.1651995-4-james.clark@arm.com>
In-Reply-To: <20230711100218.1651995-4-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 11 Jul 2023 17:43:25 -0700
Message-ID: <CAP-5=fUWV8Gq3cHV6h+x+5qNZhxj06q5KhniOnf2LoTsDBpNow@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] perf vendor events arm64: Update scale units and
 descriptions of common topdown metrics
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, renyu.zj@linux.alibaba.com,
        john.g.garry@oracle.com, namhyung@kernel.org, acme@kernel.org,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 3:02=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> Metrics will be published here [1] going forwards, but they have
> slightly different scale units. To allow autogenerated metrics to be
> added more easily, update the scale units to match.
>
> The more detailed descriptions have also been taken and added to the
> common file.
>
> [1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/tree/=
main/data/pmu/cpu/
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/arm64/sbsa.json | 24 +++++++++++-----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/sbsa.json b/tools/perf/pmu-=
events/arch/arm64/sbsa.json
> index f90b338261ac..4eed79a28f6e 100644
> --- a/tools/perf/pmu-events/arch/arm64/sbsa.json
> +++ b/tools/perf/pmu-events/arch/arm64/sbsa.json
> @@ -1,34 +1,34 @@
>  [
>      {
> -        "MetricExpr": "stall_slot_frontend / (#slots * cpu_cycles)",
> -        "BriefDescription": "Frontend bound L1 topdown metric",
> +        "MetricExpr": "100 * (stall_slot_frontend / (#slots * cpu_cycles=
))",
> +        "BriefDescription": "This metric is the percentage of total slot=
s that were stalled due to resource constraints in the frontend of the proc=
essor.",
>          "DefaultMetricgroupName": "TopdownL1",
>          "MetricGroup": "Default;TopdownL1",
>          "MetricName": "frontend_bound",
> -        "ScaleUnit": "100%"
> +        "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": "(1 - op_retired / op_spec) * (1 - stall_slot / (#=
slots * cpu_cycles))",
> -        "BriefDescription": "Bad speculation L1 topdown metric",
> +        "MetricExpr": "100 * ((1 - op_retired / op_spec) * (1 - stall_sl=
ot / (#slots * cpu_cycles)))",
> +        "BriefDescription": "This metric is the percentage of total slot=
s that executed operations and didn't retire due to a pipeline flush.\nThis=
 indicates cycles that were utilized but inefficiently.",
>          "DefaultMetricgroupName": "TopdownL1",
>          "MetricGroup": "Default;TopdownL1",
>          "MetricName": "bad_speculation",
> -        "ScaleUnit": "100%"
> +        "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": "(op_retired / op_spec) * (1 - stall_slot / (#slot=
s * cpu_cycles))",
> -        "BriefDescription": "Retiring L1 topdown metric",
> +        "MetricExpr": "100 * ((op_retired / op_spec) * (1 - stall_slot /=
 (#slots * cpu_cycles)))",
> +        "BriefDescription": "This metric is the percentage of total slot=
s that retired operations, which indicates cycles that were utilized effici=
ently.",
>          "DefaultMetricgroupName": "TopdownL1",
>          "MetricGroup": "Default;TopdownL1",
>          "MetricName": "retiring",
> -        "ScaleUnit": "100%"
> +        "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": "stall_slot_backend / (#slots * cpu_cycles)",
> -        "BriefDescription": "Backend Bound L1 topdown metric",
> +        "MetricExpr": "100 * (stall_slot_backend / (#slots * cpu_cycles)=
)",
> +        "BriefDescription": "This metric is the percentage of total slot=
s that were stalled due to resource constraints in the backend of the proce=
ssor.",
>          "DefaultMetricgroupName": "TopdownL1",
>          "MetricGroup": "Default;TopdownL1",
>          "MetricName": "backend_bound",
> -        "ScaleUnit": "100%"
> +        "ScaleUnit": "1percent of slots"
>      }
>  ]
> --
> 2.34.1
>
