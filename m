Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C95EC98B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiI0Qca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiI0QcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:32:19 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925951CE153
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:32:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y8so13941132edc.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=zRA1LH514/TWKCsvlQylSgkigIQNGzchJF4zMhBdvvc=;
        b=Jb5rNOLF8Emh076BuRUwVHpjEB49/pbLToKCLAnFDTEv8E7FOxUAtJsrI5zURn0L3a
         FFfKDS3V/AjpPg7WvvevBGAJn4D2w1VvCq3xnK14eDHAjfRU7ZqG6NTS10GH4mNjQhLY
         G3w9KpgaVNNZYSX2Pah1uHgukrdybSMtc/I4nyZhZIGNsAeNlBpZNZ5Nk21grW2rcODm
         k1q2mZmYQp9c84XWhiugj2JxgaOgtp75Ob+wEGvBhWcdDAtLc1IxaSzEosJMhNouO5+o
         LiSZIBpbsPoGiMe76YOh9cYk10Xj8Czlm4dNdIWLrPkAXrKWn3hDBBZxlo2gYaFF8fYl
         u+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zRA1LH514/TWKCsvlQylSgkigIQNGzchJF4zMhBdvvc=;
        b=vJK5QYPwUk79m1EYWkgTtYSb+BBhUXXV3DAOAuWMtrhs1XkBVGQ63ez9BsQSwJ7pFa
         kUEYymiaqeayLjrYTsBoXSJhR3L04s5xMiluPFQBzuz+apgqaJ67YxEgZF6C5yKn0jD4
         do9t3w+v82jEIQRpknrqyCBxQlTk3NYZ0+KHAVVhK6yF7MvQxr/tjnSK2+5FlO39Do5S
         Ax7EkFQuwn1bKeW8YQfEzcyJSC/Cc1z8ooP2PwX6zf4yxxGlJhBL8C6xzzLQFnO73iwD
         m2epADdPqtrhjSY8NlFqIKQYGYmaLjZQpApKK6ER/hNkF92U+eIK/Uin2y+RDi6hEYsx
         BJEw==
X-Gm-Message-State: ACrzQf1NFFsy10/abztcMbGBPiiKw7xWa7AYMIdla+MzkMWbokea44W7
        3+PAIO+9JPjUYwlL3nA5bL2NeA==
X-Google-Smtp-Source: AMsMyM7Hc6pTJOUvUT1LOcoYK1mgyc9muWRnjwTsCXVqKDZKIUDIajE+Dx4G3+Ad2zhrx5DH5UgEqw==
X-Received: by 2002:aa7:de9a:0:b0:44d:8191:44c5 with SMTP id j26-20020aa7de9a000000b0044d819144c5mr28315152edv.232.1664296335920;
        Tue, 27 Sep 2022 09:32:15 -0700 (PDT)
Received: from mbp-di-paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id t23-20020a17090616d700b0077b523d309asm1001111ejd.185.2022.09.27.09.32.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 09:32:15 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [patch v11 3/6] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220916071942.214222-4-yukuai1@huaweicloud.com>
Date:   Tue, 27 Sep 2022 18:32:13 +0200
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <11AC4611-79BC-478F-821E-7AF70BE69A04@linaro.org>
References: <20220916071942.214222-1-yukuai1@huaweicloud.com>
 <20220916071942.214222-4-yukuai1@huaweicloud.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 16 set 2022, alle ore 09:19, Yu Kuai =
<yukuai1@huaweicloud.com> ha scritto:
>=20
> From: Yu Kuai <yukuai3@huawei.com>
>=20
> Currently, bfq can't handle sync io concurrently as long as they
> are not issued from root group. This is because
> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
> bfq_asymmetric_scenario().
>=20
> The way that bfqg is counted into 'num_groups_with_pending_reqs':
>=20
> Before this patch:
> 1) root group will never be counted.
> 2) Count if bfqg or it's child bfqgs have pending requests.
> 3) Don't count if bfqg and it's child bfqgs complete all the requests.
>=20
> After this patch:
> 1) root group is counted.
> 2) Count if bfqg have pending requests.
> 3) Don't count if bfqg complete all the requests.
>=20
> With this change, the occasion that only one group is activated can be
> detected, and next patch will support concurrent sync io in the
> occasion.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
> block/bfq-iosched.c | 42 ------------------------------------------
> block/bfq-iosched.h | 18 +++++++++---------
> block/bfq-wf2q.c    | 23 ++++++++---------------
> 3 files changed, 17 insertions(+), 66 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0dcae2f52896..970b302a7a3e 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -970,48 +970,6 @@ void __bfq_weights_tree_remove(struct bfq_data =
*bfqd,
> void bfq_weights_tree_remove(struct bfq_data *bfqd,
> 			     struct bfq_queue *bfqq)
> {
> -	struct bfq_entity *entity =3D bfqq->entity.parent;
> -
> -	for_each_entity(entity) {
> -		struct bfq_sched_data *sd =3D entity->my_sched_data;
> -
> -		if (sd->next_in_service || sd->in_service_entity) {
> -			/*
> -			 * entity is still active, because either
> -			 * next_in_service or in_service_entity is not
> -			 * NULL (see the comments on the definition of
> -			 * next_in_service for details on why
> -			 * in_service_entity must be checked too).
> -			 *
> -			 * As a consequence, its parent entities are
> -			 * active as well, and thus this loop must
> -			 * stop here.
> -			 */
> -			break;
> -		}
> -
> -		/*
> -		 * The decrement of num_groups_with_pending_reqs is
> -		 * not performed immediately upon the deactivation of
> -		 * entity, but it is delayed to when it also happens
> -		 * that the first leaf descendant bfqq of entity gets
> -		 * all its pending requests completed. The following
> -		 * instructions perform this delayed decrement, if
> -		 * needed. See the comments on
> -		 * num_groups_with_pending_reqs for details.
> -		 */
> -		if (entity->in_groups_with_pending_reqs) {
> -			entity->in_groups_with_pending_reqs =3D false;
> -			bfqd->num_groups_with_pending_reqs--;
> -		}
> -	}
> -
> -	/*
> -	 * Next function is invoked last, because it causes bfqq to be
> -	 * freed if the following holds: bfqq is not in service and
> -	 * has no dispatched request. DO NOT use bfqq after the next
> -	 * function invocation.
> -	 */
> 	__bfq_weights_tree_remove(bfqd, bfqq,
> 				  &bfqd->queue_weights_tree);

Why are you keeping the wrapper function bfq_weights_tree_remove() if it =
contains only the invocation of __bfq_weights_tree_remove()?

> }
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 338ff5418ea8..257acb54c6dc 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -496,27 +496,27 @@ struct bfq_data {
> 	struct rb_root_cached queue_weights_tree;
>=20
> 	/*
> -	 * Number of groups with at least one descendant process that
> +	 * Number of groups with at least one process that
> 	 * has at least one request waiting for completion. Note that
> 	 * this accounts for also requests already dispatched, but not
> 	 * yet completed. Therefore this number of groups may differ
> 	 * (be larger) than the number of active groups, as a group is
> 	 * considered active only if its corresponding entity has
> -	 * descendant queues with at least one request queued. This
> +	 * queues with at least one request queued. This
> 	 * number is used to decide whether a scenario is symmetric.
> 	 * For a detailed explanation see comments on the computation
> 	 * of the variable asymmetric_scenario in the function
> 	 * bfq_better_to_idle().
> 	 *
> 	 * However, it is hard to compute this number exactly, for
> -	 * groups with multiple descendant processes. Consider a group
> -	 * that is inactive, i.e., that has no descendant process with
> +	 * groups with multiple processes. Consider a group
> +	 * that is inactive, i.e., that has no process with
> 	 * pending I/O inside BFQ queues. Then suppose that
> 	 * num_groups_with_pending_reqs is still accounting for this
> -	 * group, because the group has descendant processes with some
> +	 * group, because the group has processes with some
> 	 * I/O request still in flight. num_groups_with_pending_reqs
> 	 * should be decremented when the in-flight request of the
> -	 * last descendant process is finally completed (assuming that
> +	 * last process is finally completed (assuming that
> 	 * nothing else has changed for the group in the meantime, in
> 	 * terms of composition of the group and active/inactive state =
of child
> 	 * groups and processes). To accomplish this, an additional
> @@ -525,7 +525,7 @@ struct bfq_data {
> 	 * we resort to the following tradeoff between simplicity and
> 	 * accuracy: for an inactive group that is still counted in
> 	 * num_groups_with_pending_reqs, we decrement
> -	 * num_groups_with_pending_reqs when the first descendant
> +	 * num_groups_with_pending_reqs when the first
> 	 * process of the group remains with no request waiting for
> 	 * completion.
> 	 *
> @@ -533,12 +533,12 @@ struct bfq_data {
> 	 * carefulness: to avoid multiple decrements, we flag a group,
> 	 * more precisely an entity representing a group, as still
> 	 * counted in num_groups_with_pending_reqs when it becomes
> -	 * inactive. Then, when the first descendant queue of the
> +	 * inactive. Then, when the first queue of the
> 	 * entity remains with no request waiting for completion,
> 	 * num_groups_with_pending_reqs is decremented, and this flag
> 	 * is reset. After this flag is reset for the entity,
> 	 * num_groups_with_pending_reqs won't be decremented any
> -	 * longer in case a new descendant queue of the entity remains
> +	 * longer in case a new queue of the entity remains
> 	 * with no request waiting for completion.
> 	 */
> 	unsigned int num_groups_with_pending_reqs;
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 5549ccf09cd2..5e8224c96921 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -984,19 +984,6 @@ static void __bfq_activate_entity(struct =
bfq_entity *entity,
> 		entity->on_st_or_in_serv =3D true;
> 	}
>=20
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
> -		struct bfq_group *bfqg =3D
> -			container_of(entity, struct bfq_group, entity);
> -		struct bfq_data *bfqd =3D bfqg->bfqd;
> -
> -		if (!entity->in_groups_with_pending_reqs) {
> -			entity->in_groups_with_pending_reqs =3D true;
> -			bfqd->num_groups_with_pending_reqs++;
> -		}
> -	}
> -#endif
> -
> 	bfq_update_fin_time_enqueue(entity, st, backshifted);
> }
>=20
> @@ -1653,7 +1640,8 @@ void =
bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
> 	if (!entity->in_groups_with_pending_reqs) {
> 		entity->in_groups_with_pending_reqs =3D true;
> #ifdef CONFIG_BFQ_GROUP_IOSCHED
> -		bfqq_group(bfqq)->num_queues_with_pending_reqs++;
> +		if (!(bfqq_group(bfqq)->num_queues_with_pending_reqs++))
> +			bfqq->bfqd->num_groups_with_pending_reqs++;
> #endif
> 	}
> }
> @@ -1665,7 +1653,8 @@ void =
bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
> 	if (entity->in_groups_with_pending_reqs) {
> 		entity->in_groups_with_pending_reqs =3D false;
> #ifdef CONFIG_BFQ_GROUP_IOSCHED
> -		bfqq_group(bfqq)->num_queues_with_pending_reqs--;
> +		if (!(--bfqq_group(bfqq)->num_queues_with_pending_reqs))
> +			bfqq->bfqd->num_groups_with_pending_reqs--;
> #endif
> 	}
> }
> @@ -1694,6 +1683,10 @@ void bfq_del_bfqq_busy(struct bfq_queue *bfqq, =
bool expiration)
>=20
> 	if (!bfqq->dispatched) {
> 		bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
> +		/*
> +		 * Next function is invoked last, because it causes bfqq =
to be
> +		 * freed. DO NOT use bfqq after the next function =
invocation.
> +		 */

Great, you moved this comment to the best place.

Thanks,
Paolo

> 		bfq_weights_tree_remove(bfqd, bfqq);
> 	}
> }
> --=20
> 2.31.1
>=20

