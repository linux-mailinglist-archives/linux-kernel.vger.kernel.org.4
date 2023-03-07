Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2996AD6CF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCGFc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCGFc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:32:57 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1382D7D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 21:32:54 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m6so15651518lfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 21:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678167173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+hoIWbYaHKn+jXxJFShlyzgyWQZXEqFyUdN31BS+ow=;
        b=QxVrRKuw+Vhq1UaNtIwVtPEhQ0dYsjqf8eV2dFZeG0nSPFsyRW3ctmKiu/V9AeyD0+
         wu5DTGMmWYx5CKpc+mEk700WHgFjEzyrj7M9A4nM6usVle4vBhIx31AiTaAadMYrB5+u
         TGD5v9xVz+NYEYAIzyNmRlrpIllfE4gwq+nsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678167173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+hoIWbYaHKn+jXxJFShlyzgyWQZXEqFyUdN31BS+ow=;
        b=n7WnWaBnK29yhbhFzJzv0FIwzg81bzPz8k9+e9bs4yRt0jyRPczwZtVrb+CIs8U++W
         G8gtUWs2wZXdSIclesOk6lNs8vS+P926uMm9FJawtGEm6hhPBy/U2SiW56zyLbuw39Qb
         +X9oQajW9iuyUEHQhrMGOy2CJHD20Z1KHEu4cpOsfLA1CbiY6mry+9ieDzaGGBaqf8F7
         zBsHM6qveRR6FiG+kocpsEjN2jEZMAMc3UnypSblc2kmqR5Pf0Bc+CUJNEppOfAtzJmR
         ECLo1BTyefOBDdTAf9FkwHuFshCYH8w8VtmmcuPYOausBBaGioFM5YGw8anHdLn5zfU0
         8vow==
X-Gm-Message-State: AO0yUKV2QocvS4iyKqfiJwDnmmGFKv/ROEmTXJNyP8F6WOUqOS9VUipw
        4Jmlntp0r25JvY/tfii1b+TZhVn4KqtY0VvGt2nkNg==
X-Google-Smtp-Source: AK7set9nuJxu/QeD4Zon6yI0dNi/RPi/rmEoSdQV9+KgJ3VsUP4rBA4yHXiH6/oC6o6yqwVpXHDR7YcuZGQI2nyxKCs=
X-Received: by 2002:a05:6512:24f:b0:4dd:fd4e:5a21 with SMTP id
 b15-20020a056512024f00b004ddfd4e5a21mr3969019lfo.11.1678167172717; Mon, 06
 Mar 2023 21:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20230307030457.3499834-1-joel@joelfernandes.org>
 <753b72f5ecd03f94511495a333eb192c5fc42087.camel@perches.com>
 <CAEXW_YRYnikDRTQXwrTpTsQ1r-32FRPABj_Viu+X6Qr7EWqh4g@mail.gmail.com>
 <802731d7bf187573a9084cb23196c096be81b5e1.camel@perches.com>
 <20230307044104.GA3532764@google.com> <497c07579fb51ed6f0b8a72471017b4dec258e9e.camel@perches.com>
 <CAEXW_YQt976k6tRJBoYy=S-CpacgB+MpMr-H=TEtZBaP=CPwnQ@mail.gmail.com> <912474d3804791ef5757a44bae6ab72701e15bc3.camel@perches.com>
In-Reply-To: <912474d3804791ef5757a44bae6ab72701e15bc3.camel@perches.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 7 Mar 2023 00:32:40 -0500
Message-ID: <CAEXW_YQbSySm++iXeXn7uMdGVatCKo88L5WXecL2=WkJg7XDEg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Error out if deprecated RCU API used
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 12:22=E2=80=AFAM Joe Perches <joe@perches.com> wrote=
:
>
> On Tue, 2023-03-07 at 00:11 -0500, Joel Fernandes wrote:
>
> > Do you mind sharing which tree you are looking at? I checked both
> > 6.3-rc1 and linux-next.
> >
> > Your grep returned:
> >
> > kernel/trace/trace_osnoise.c:   kvfree_rcu(inst);
> > kernel/trace/trace_probe.c:     kvfree_rcu(link);
> > lib/test_vmalloc.c:             kvfree_rcu(p);
> > mm/list_lru.c:   * We need kvfree_rcu() here. And the walking of the li=
st
> > net/core/pktgen.c:      /* Don't need rcu_barrier() due to use of kfree=
_rcu() */
> > net/core/sysctl_net_core.c:
> > kvfree_rcu(orig_sock_table);
> > net/core/sysctl_net_core.c:                             kfree_rcu(cur);
> > net/mac802154/scan.c:   kfree_rcu(request);
> > net/mac802154/scan.c:   kfree_rcu(request);
>
> rather old.  I'm not subscribed and haven't been following much.
>
> Add linux-next specific files for 20230217

I am surprised though why you don't see the usage in trace_osnoise.c
though because that was added in 2021 (see diff below).

Anyway, I take it you are Ok with the checkpatch patch. If so, do
provide your Ack tag in advance. We can push from our side only if
needed. There is a chance that we may not need it if we are successful
in having made the conversions to the "good API" in time for the next
merge window.

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 7520d43aed55..4719a848bf17 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -138,8 +138,7 @@ static void osnoise_unregister_instance(struct
trace_array *tr)
        if (!found)
                return;

-       synchronize_rcu();
-       kfree(inst);
+       kvfree_rcu(inst);
 }

 /*


>
> Updating to today's next:
>
> Add linux-next specific files for 20230307
>
> I get several instances:
>
> $ git grep -P '\bkv?free_rcu\s*\(' -- '*.[ch]' | grep -v -P 'kv?free_rcu\=
s*\([^,]+,.*\)'
> drivers/block/drbd/drbd_nl.c:   kvfree_rcu(old_disk_conf);
> drivers/block/drbd/drbd_nl.c:   kvfree_rcu(old_net_conf);
> drivers/block/drbd/drbd_nl.c:           kvfree_rcu(old_disk_conf);
> drivers/block/drbd/drbd_receiver.c:     kvfree_rcu(old_net_conf);
> drivers/block/drbd/drbd_receiver.c:                     kvfree_rcu(old_di=
sk_conf);
> drivers/block/drbd/drbd_state.c:                kvfree_rcu(old_conf);
> drivers/infiniband/core/device.c:               kfree_rcu(container_of(de=
v->port_data, struct ib_port_data_rcu,
> drivers/infiniband/core/rdma_core.c:     * kfree_rcu(). However the objec=
t may still have been released and
> drivers/infiniband/sw/rxe/rxe_mr.c:     kfree_rcu(mr);
> drivers/misc/vmw_vmci/vmci_context.c:           kvfree_rcu(notifier);
> drivers/misc/vmw_vmci/vmci_event.c:     kvfree_rcu(s);
> drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c:       kfree_rcu=
(int_port);
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c:      kfree_rcu=
(tx_sa);
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c:      kfree_rcu=
(rx_sc);
> drivers/target/target_core_configfs.c:                   * callbacks to c=
omplete post kfree_rcu(), before allowing
> fs/ext4/super.c:                                kfree_rcu(qname);
> include/linux/rcupdate.h: *     kvfree_rcu(ptr);
> include/linux/rcupdate.h:#define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_AR=
GS__,          \
> include/linux/rcutiny.h:        // kvfree_rcu(one_arg) call.
> include/rdma/ib_verbs.h:        struct rcu_head         rcu;            /=
* kfree_rcu() overhead */
> include/scsi/scsi_device.h: * @rcu: For kfree_rcu().
> kernel/rcu/rcuscale.c:          pr_alert("CONFIG_RCU_LAZY is disabled, fa=
lling back to kfree_rcu() for delayed RCU kfree'ing\n");
> kernel/rcu/tree.c: * struct kvfree_rcu_bulk_data - single block to store =
kvfree_rcu() pointers
> kernel/rcu/tree.c: * @records: Array of the kvfree_rcu() pointers
> kernel/rcu/tree.c: * struct kfree_rcu_cpu_work - single batch of kfree_rc=
u() requests
> kernel/rcu/tree.c: * @head_free: List of kfree_rcu() objects waiting for =
a grace period
> kernel/rcu/tree.c: * @bulk_head_free: Bulk-List of kvfree_rcu() objects w=
aiting for a grace period
> kernel/rcu/tree.c: * struct kfree_rcu_cpu - batch up kfree_rcu() requests=
 for RCU grace period
> kernel/rcu/tree.c: * @head: List of kfree_rcu() objects not yet waiting f=
or a grace period
> kernel/rcu/tree.c: * @bulk_head: Bulk-List of kvfree_rcu() objects not ye=
t waiting for a grace period
> kernel/rcu/tree.c: * @krw_arr: Array of batches of kfree_rcu() objects wa=
iting for a grace period
> kernel/rcu/tree.c:       * double-argument of kvfree_rcu().  This happens=
 when the
> kernel/rcu/tree.c: * reduce the number of grace periods during heavy kfre=
e_rcu()/kvfree_rcu() load.
> kernel/rcu/tree.c:              // Probable double kfree_rcu(), just leak=
.
> kernel/trace/trace_osnoise.c:   kvfree_rcu(inst);
> kernel/trace/trace_probe.c:     kvfree_rcu(link);
> net/core/pktgen.c:      /* Don't need rcu_barrier() due to use of kfree_r=
cu() */
> net/core/sysctl_net_core.c:                             kvfree_rcu(orig_s=
ock_table);
> net/core/sysctl_net_core.c:                             kfree_rcu(cur);
>
