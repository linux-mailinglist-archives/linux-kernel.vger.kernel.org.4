Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE72563A0FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 06:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiK1FwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 00:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiK1Fv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 00:51:56 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6772D13EBB;
        Sun, 27 Nov 2022 21:51:39 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so12913010pjh.2;
        Sun, 27 Nov 2022 21:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QQEq3RRCmD+WRW4QSwoirpwBHFTkPX7G7ZRHJATYnA=;
        b=MshPV8ND1o+LQAWckzG24DHtPeaVLB4h8eRzFdhiSqeCIb2vqVtlvkhpL1yuWfurFa
         XDzGiD2jl64X6zOhS0WHOnEL0Y2o5mw1Ztw/Om/SitiPF8Gv/b86ltunUSP5nrQq6TKa
         yQdXmDByUxP1rpP/orqsXTmWpv2gXafOJC4jhcsz0uEOFUSdYcfMnjJ7uL5/r1Q8orVV
         RxaVLWECEX39jHzY20r8s4W5jcPohmLTF56pTPElkeKdrUs3XYydR4divsdUqYR4r+zu
         FaAwvEARC2t4fUV3IA2g+iwUSxfWTJ/d15Ls5i1YNy2ulhFIrgqImM64LRbSXUQd63g+
         XpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QQEq3RRCmD+WRW4QSwoirpwBHFTkPX7G7ZRHJATYnA=;
        b=WUxXqD8RmFHITrIHzNHn1Qp2ZJl6MXtYv9Qjqbypf01ql2wBeLrODFQ+9cpe14BkiG
         p0SkgyaV08iYe0Qi2kCxLbCC3b3wjbxXb9iSwN34F7yICB5w0yhyFjItyK3Q1EOPU1mu
         SGTS5DT2UczStQNHo49CyhQgLivjs4VEuHTHoqjIOFz90B/63gGwzJGIx+DcQkqejcKH
         1iXXTKu77c1Goa1+FEje/smvzsV6ArU0GFmEOk4lc1Pp7iAl4UQH7N1jqIfwRWJlUYaC
         VJluGvzIRSPxuBiucNhL/fDelNrjFRJuytTKTF8VA42BmvK/UFyhqLn/0woi7BN1QaZY
         cI+g==
X-Gm-Message-State: ANoB5pm82r+eUJJ9uPFGEmuWL8+dUTXF6CAyGIpaOtvtJXPvEUAmFa+d
        HV2DTWiscrutS9T+BD4CzVnSGVdWrzcksGVm9YTEW6xDknf2JQ==
X-Google-Smtp-Source: AA0mqf7nXARmYRH0l6QRdMzRimUX+IFnbqejLvEeGi8HJIxnSGaOuJS35IzDaYeGAkm0wzDsmtTiyQ5yEnWQ7oql1m0=
X-Received: by 2002:a17:90a:d918:b0:219:3e68:1d03 with SMTP id
 c24-20020a17090ad91800b002193e681d03mr1712968pjv.77.1669614698803; Sun, 27
 Nov 2022 21:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20221118054725.80414-1-michael@allwinnertech.com>
 <CA+Da2qxP2gvUc2=n5xW7_YEcgevGpDhqbcVFWVbF0c6DqXDXHA@mail.gmail.com>
 <23c0a4ae-d714-cfb1-aeb5-68b66b5bf0ee@allwinnertech.com> <CA+Da2qwXLapwUDX+GrFkNQE9so2Tj=ymY1YS396J_N_c+9EHYw@mail.gmail.com>
 <d4ecd7cf-0dd0-570f-0560-a5886f464429@allwinnertech.com>
In-Reply-To: <d4ecd7cf-0dd0-570f-0560-a5886f464429@allwinnertech.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Mon, 28 Nov 2022 13:51:27 +0800
Message-ID: <CA+Da2qx_sfu0Vn5XW5MUkFXVBe09=YerPjHrdETWJOAYCKOimQ@mail.gmail.com>
Subject: Re: [PATCH] mmc:mmc-hsq:use fifo to dispatch mmc_request
To:     Michael Wu <michael@allwinnertech.com>
Cc:     ulf.hansson@linaro.org, wenchao.chen@unisoc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:55 AM Michael Wu <michael@allwinnertech.com> wro=
te:
>
> On 11/24/2022 10:56 AM, Wenchao Chen wrote:
> > On Mon, Nov 21, 2022 at 2:19 PM Michael Wu <michael@allwinnertech.com> =
wrote:
> >>
> >> On 11/18/2022 7:43 PM, Wenchao Chen wrote:
> >>> On Fri, Nov 18, 2022 at 1:52 PM Michael Wu <michael@allwinnertech.com=
> wrote:
> >>>>
> >>>> Current next_tag selection will cause a large delay in some requests=
 and
> >>>> destroy the scheduling results of the block scheduling layer. Becaus=
e the
> >>>> issued mrq tags cannot ensure that each time is sequential, especial=
ly when
> >>>> the IO load is heavy. In the fio performance test, we found that 4k =
random
> >>>> read data was sent to mmc_hsq to start calling request_atomic It tak=
es
> >>>> nearly 200ms to process the request, while mmc_hsq has processed tho=
usands
> >>>> of other requests. So we use fifo here to ensure the first in, first=
 out
> >>>> feature of the request and avoid adding additional delay to the requ=
est.
> >>>>
> >>>
> >>> Hi Michael
> >>> Is the test device an eMMC?
> >>> Could you share the fio test command if you want?
> >>> Can you provide more logs?
> >>>
> >> Hi Wenchao,
> >> Yes, the tested device is emmc.
> >> The test command we used is `./fio -name=3DRand_Read_IOPS_Test
> >> -group_reporting -rw=3Drandom -bs=3D4K -numjobs=3D8 -directory=3D/data=
/data
> >> -size=3D1G -io_size=3D64M -nrfiles=3D1 -direct=3D1 -thread && rm
> >> /data/Rand_Read_IOPS_Test *`,  which replaces the io performance rando=
m
> >> read performance test of androidbench, and the file size is set to 1G,=
 8
> >> thread test configuration. Where /data uses f2fs and /data/data is a
> >> file encrypted path.
> >>
> >> After enabling the hsq configuration, we can clearly see from below fi=
o
> >> test log that the minimum value of random reading is 3175 iops and the
> >> maximum value is 8554iops, and the maximum delay of io completion is
> >> about 200ms.
> >> ```
> >>       clat percentiles (usec):
> >>        |  1.00th=3D[   498],  5.00th=3D[   865], 10.00th=3D[   963], 2=
0.00th=3D[
> >>    1045],
> >>        | 30.00th=3D[  1090], 40.00th=3D[  1139], 50.00th=3D[  1172], 6=
0.00th=3D[
> >>    1221],
> >>        | 70.00th=3D[  1254], 80.00th=3D[  1319], 90.00th=3D[  1401], 9=
5.00th=3D[
> >>    1614],
> >>        | 99.00th=3D[  2769], 99.50th=3D[  3589], 99.90th=3D[ 31589], 9=
9.95th=3D[
> >> 66323],
> >>        | 99.99th=3D[200279]
> >>      bw (  KiB/s): min=3D12705, max=3D34225, per=3D100.00%, avg=3D2393=
1.79,
> >> stdev=3D497.40, samples=3D345
> >>      iops        : min=3D 3175, max=3D 8554, avg=3D5981.67, stdev=3D12=
4.38,
> >> samples=3D345
> >> ```
> >>
> >>
> >> ```
> >>       clat percentiles (usec):
> >>        |  1.00th=3D[  799],  5.00th=3D[  938], 10.00th=3D[  963], 20.0=
0th=3D[  979],
> >>        | 30.00th=3D[  996], 40.00th=3D[ 1004], 50.00th=3D[ 1020], 60.0=
0th=3D[ 1045],
> >>        | 70.00th=3D[ 1074], 80.00th=3D[ 1106], 90.00th=3D[ 1172], 95.0=
0th=3D[ 1237],
> >>        | 99.00th=3D[ 1450], 99.50th=3D[ 1516], 99.90th=3D[ 1762], 99.9=
5th=3D[ 2180],
> >>        | 99.99th=3D[ 9503]
> >>      bw (  KiB/s): min=3D29200, max=3D30944, per=3D100.00%, avg=3D3017=
8.91,
> >> stdev=3D53.45, samples=3D272
> >>      iops        : min=3D 7300, max=3D 7736, avg=3D7544.62, stdev=3D13=
.38,
> >> samples=3D272
> >> ```
> >> When NOT enabling hsq, the minimum value of random reading is 7300 iop=
s
> >> and the maximum value is 7736 iops, and the maximum delay of io is onl=
y
> >> 9 ms. Finally, we added debug to the mmc driver. The reason for locati=
ng
> >> the 200ms delay of hsq is due to the next tag selection of hsq.
> >>
> >
> > Thank you very much for your Log. This patch can reduce latency, but I
> > have some questions:
> > 1. FIO -rw does not have random, but it does have randread. Do you use
> > randread? In addition, "IO_SIZE=3D64M" means only 64M data is tested?
> > Refer to FIO:
> > https://fio.readthedocs.io/en/latest/fio_doc.html?highlight=3Dio_size#c=
mdoption-arg-io-size
> Hi Wenchao,
>
> Yes, I used "randread". (Sorry, I wrote the parameter "random"
> incorrectly.) The reason why I used "io_size=3D64M" is that I found the
> performance of hsq was degraded when using the AndroBench for testing on
> android13. Therefore, fio is used to simulate the AndroBench for
> debugging. The AndroBench is configured with 8 threads while 1G files
> per thread, and only 64M data for random read testing=EF=BC=88This item i=
s not
> configurable=EF=BC=89.
>
> > 2. The style of "tag_tail" should remain the same as that of
> > "next_tag". Would "tail_tag" be better?
> Thank you for your suggestion. I'll modify 'tag_tail' as 'tail_tag'.
>
> > 3. It is better to provide a comparison of sequential read, sequential
> > write and random writeHere is the performance data tested by AndroBench=
:
>
> -------------------------------------------------------------------------
>        io performance data from AndroBench (filesize=3D1G, 8 threads)
> -------------------------------------------------------------------------
> mmc configure     | original hsq  |  without hsq  |  hsq with this patch
> -------------------------------------------------------------------------
> Sequential write      58.23 MB/s       51.35 MB/s        56.15 MB/s
> Sequential read      138.24 MB/s      143.65 MB/s        146.4 MB/s
> random write        2900.11 iops     1887.13 iops      2982.02 iops
> random read         4764.45 iops     5485.19 iops      6786.42 iops
>
> Here's a preview of patch-v2. If it's OK, I'll submit it soon. Thank you.
>
> --
> mmc:mmc-hsq:use fifo to dispatch mmc_request
>
> Current next_tag selection will cause a large delay in some requests and
> destroy the scheduling results of the block scheduling layer. Because
> the issued mrq tags cannot ensure that each time is sequential,
> especially when the IO load is heavy. In the fio performance test, we
> found that 4k random read data was sent to mmc_hsq to start calling
> request_atomic It takes nearly 200ms to process the request, while
> mmc_hsq has processed thousands of other requests. So we use fifo here
> to ensure the first in, first out feature of the request and avoid
> adding additional delay to the request.
>
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index 9d35453e7371..424dc7b07858 100644
> --- a/drivers/mmc/host/mmc_hsq.c
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -13,9 +13,6 @@
>
>   #include "mmc_hsq.h"
>
> -#define HSQ_NUM_SLOTS  64
> -#define HSQ_INVALID_TAG        HSQ_NUM_SLOTS
> -
>   static void mmc_hsq_retry_handler(struct work_struct *work)
>   {
>         struct mmc_hsq *hsq =3D container_of(work, struct mmc_hsq, retry_=
work);
> @@ -73,7 +70,6 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
>
>   static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
>   {
> -       struct hsq_slot *slot;
>         int tag;
>
>         /*
> @@ -82,29 +78,12 @@ static void mmc_hsq_update_next_tag(struct mmc_hsq
> *hsq, int remains)
>          */
>         if (!remains) {
>                 hsq->next_tag =3D HSQ_INVALID_TAG;
> +               hsq->tail_tag =3D HSQ_INVALID_TAG;
>                 return;
>         }
>
> -       /*
> -        * Increasing the next tag and check if the corresponding request=
 is
> -        * available, if yes, then we found a candidate request.
> -        */
> -       if (++hsq->next_tag !=3D HSQ_INVALID_TAG) {
> -               slot =3D &hsq->slot[hsq->next_tag];
> -               if (slot->mrq)
> -                       return;
> -       }
> -
> -       /* Othersie we should iterate all slots to find a available tag. =
*/
> -       for (tag =3D 0; tag < HSQ_NUM_SLOTS; tag++) {
> -               slot =3D &hsq->slot[tag];
> -               if (slot->mrq)
> -                       break;
> -       }
> -
> -       if (tag =3D=3D HSQ_NUM_SLOTS)
> -               tag =3D HSQ_INVALID_TAG;
> -
> +       tag =3D hsq->tag_slot[hsq->next_tag];
> +       hsq->tag_slot[hsq->next_tag] =3D HSQ_INVALID_TAG;
>         hsq->next_tag =3D tag;
>   }
>
> @@ -233,8 +212,14 @@ static int mmc_hsq_request(struct mmc_host *mmc,
> struct mmc_request *mrq)
>          * Set the next tag as current request tag if no available
>          * next tag.
>          */
> -       if (hsq->next_tag =3D=3D HSQ_INVALID_TAG)
> +       if (hsq->next_tag =3D=3D HSQ_INVALID_TAG) {
>                 hsq->next_tag =3D tag;
> +               hsq->tail_tag =3D tag;
> +               hsq->tag_slot[hsq->tail_tag] =3D HSQ_INVALID_TAG;
> +       } else {
> +               hsq->tag_slot[hsq->tail_tag] =3D tag;
> +               hsq->tail_tag =3D tag;
> +       }
>
>         hsq->qcnt++;
>
> @@ -339,8 +324,10 @@ static const struct mmc_cqe_ops mmc_hsq_ops =3D {
>
>   int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
>   {
> +       int i;
>         hsq->num_slots =3D HSQ_NUM_SLOTS;
>         hsq->next_tag =3D HSQ_INVALID_TAG;
> +       hsq->tail_tag =3D HSQ_INVALID_TAG;
>
>         hsq->slot =3D devm_kcalloc(mmc_dev(mmc), hsq->num_slots,
>                                  sizeof(struct hsq_slot), GFP_KERNEL);
> @@ -351,6 +338,9 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct
> mmc_host *mmc)
>         hsq->mmc->cqe_private =3D hsq;
>         mmc->cqe_ops =3D &mmc_hsq_ops;
>
> +       for (i =3D 0; i < HSQ_NUM_SLOTS; i++)
> +               hsq->tag_slot[i] =3D HSQ_INVALID_TAG;
> +
>         INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
>         spin_lock_init(&hsq->lock);
>         init_waitqueue_head(&hsq->wait_queue);
> diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
> index ffdd9cd172c3..1808024fc6c5 100644
> --- a/drivers/mmc/host/mmc_hsq.h
> +++ b/drivers/mmc/host/mmc_hsq.h
> @@ -2,6 +2,9 @@
>   #ifndef LINUX_MMC_HSQ_H
>   #define LINUX_MMC_HSQ_H
>
> +#define HSQ_NUM_SLOTS  64
> +#define HSQ_INVALID_TAG        HSQ_NUM_SLOTS
> +
>   struct hsq_slot {
>         struct mmc_request *mrq;
>   };
> @@ -17,6 +20,8 @@ struct mmc_hsq {
>         int next_tag;
>         int num_slots;
>         int qcnt;
> +       int tail_tag;
> +       int tag_slot[HSQ_NUM_SLOTS];
>
>         bool enabled;
>         bool waiting_for_idle;
>
> --
> Regards,
> Michael Wu

That's very good, thanks.

Cc: baolin.wang@linux.alibaba.com

Reviewed-by: Wenchao Chen <wenchao.chen@unisoc.com>
