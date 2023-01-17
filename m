Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6189F66E818
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjAQVCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjAQVA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:00:58 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708DA4A1D6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:28:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NxJcm2LXMz9v7Jk
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:20:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
        by APP2 (Coremail) with SMTP id GxC2BwC3imGg9sZjq_yjAA--.64912S2;
        Tue, 17 Jan 2023 20:27:38 +0100 (CET)
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
To:     paulmck@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: [PATCH] tools/memory-model: Make ppo a subrelation of po
Date:   Tue, 17 Jan 2023 20:31:59 +0100
Message-Id: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GxC2BwC3imGg9sZjq_yjAA--.64912S2
X-Coremail-Antispam: 1UD129KBjvAXoW3CrWxZF43tw13Ar4xCrW8Crg_yoW8Gr4DXo
        Wxuws7uw48Kr1jg3yDKrnYyFy7WFZ7uF1fKr15KFnFg3Wqqrn5Aa47J3s7Wa43Xr4rKanx
        JFyUXasrKr98tF4fn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYq7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
        W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxV
        AFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3
        JwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUosqXDUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in the documentation and implied by its name, the ppo
(preserved program order) relation is intended to link po-earlier
to po-later instructions under certain conditions.  However, a
corner case currently allows instructions to be linked by ppo that
are not executed by the same thread, i.e., instructions are being
linked that have no po relation.

This happens due to the mb/strong-fence relations, which (as one
case) provide order when locks are passed between threads followed
by an smp_mb__after_unlock_lock() fence.  This is illustrated in
the following litmus test (as can be seen when using herd7 with
`doshow ppo`):

P0(int *x, int *y)
{
    spin_lock(x);
    spin_unlock(x);
}

P1(int *x, int *y)
{
    spin_lock(x);
    smp_mb__after_unlock_lock();
    *y = 1;
}

The ppo relation will link P0's spin_lock(x) and P1's *y=1,
because P0 passes a lock to P1 which then uses this fence.

The patch makes ppo a subrelation of po by eliminating this
possibility from mb and strong-fence, and instead introduces the
notion of strong ordering operations, which are allowed to link
events of distinct threads.

Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
---
 .../Documentation/explanation.txt             | 101 +++++++++++-------
 tools/memory-model/linux-kernel.cat           |  20 ++--
 2 files changed, 76 insertions(+), 45 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index e901b47236c3..4f5f6ac098de 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -865,14 +865,44 @@ propagates stores.  When a fence instruction is executed on CPU C:
 	propagate to all other CPUs before any instructions po-after
 	the strong fence are executed on C.
 
-The propagation ordering enforced by release fences and strong fences
-affects stores from other CPUs that propagate to CPU C before the
-fence is executed, as well as stores that are executed on C before the
-fence.  We describe this property by saying that release fences and
-strong fences are A-cumulative.  By contrast, smp_wmb() fences are not
-A-cumulative; they only affect the propagation of stores that are
-executed on C before the fence (i.e., those which precede the fence in
-program order).
+	Whenever any CPU C' executes an unlock operation U such that
+	CPU C executes a lock operation L followed by a po-later
+	smp_mb__after_unlock_lock() fence, and L is either a later lock
+	operation on the lock released by U or is po-after U, then any
+	store that propagates to C' before U must propagate to all other
+	CPUs before any instructions po-after the fence are executed on C.
+
+While smp_wmb() and release fences only force certain earlier stores
+to propagate to another CPU C' before certain later stores propagate
+to the same CPU C', strong fences and smp_mb__after_unlock_lock()
+force those stores to propagate to all other CPUs before any later
+instruction is executed.  We collectively refer to the latter
+operations as strong ordering operations, as they provide much
+stronger ordering in two ways:
+
+	Firstly, strong ordering operations also create order between
+	earlier stores and later reads.
+
+	Secondly, strong ordering operations create a form of global
+	ordering: When an earlier store W propagates to CPU C and is
+	ordered by a strong ordering operation with a store W' of C,
+	and another CPU C' observes W' and in response issues yet
+	another store W'', then W'' also can not propagate to any CPU
+	before W.  By contrast, a release fence or smp_wmb() would only
+	order W and W', but not force any ordering between W and W''.
+	To summarize, the ordering forced by strong ordering operations
+	extends to later stores of all CPUs, while other fences only
+	force ordering with relation to stores on the CPU that executes
+	the fence.
+
+The propagation ordering enforced by release fences and strong ordering
+operations affects stores from other CPUs that propagate to CPU C before
+the fence is executed, as well as stores that are executed on C before
+the fence.  We describe this property by saying that release fences and
+strong ordering operations are A-cumulative.  By contrast, smp_wmb()
+fences are not A-cumulative; they only affect the propagation of stores
+that are executed on C before the fence (i.e., those which precede the
+fence in program order).
 
 rcu_read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
 other properties which we discuss later.
@@ -1425,36 +1455,36 @@ requirement is the content of the LKMM's "happens-before" axiom.
 
 The LKMM defines yet another relation connected to times of
 instruction execution, but it is not included in hb.  It relies on the
-particular properties of strong fences, which we cover in the next
-section.
+particular properties of strong ordering operations, which we cover in the
+next section.
 
 
 THE PROPAGATES-BEFORE RELATION: pb
 ----------------------------------
 
 The propagates-before (pb) relation capitalizes on the special
-features of strong fences.  It links two events E and F whenever some
-store is coherence-later than E and propagates to every CPU and to RAM
-before F executes.  The formal definition requires that E be linked to
-F via a coe or fre link, an arbitrary number of cumul-fences, an
-optional rfe link, a strong fence, and an arbitrary number of hb
-links.  Let's see how this definition works out.
+features of strong ordering operations.  It links two events E and F
+whenever some store is coherence-later than E and propagates to every
+CPU and to RAM before F executes.  The formal definition requires that
+E be linked to F via a coe or fre link, an arbitrary number of
+cumul-fences, an optional rfe link, a strong ordering operation, and an
+arbitrary number of hb links.  Let's see how this definition works out.
 
 Consider first the case where E is a store (implying that the sequence
 of links begins with coe).  Then there are events W, X, Y, and Z such
 that:
 
-	E ->coe W ->cumul-fence* X ->rfe? Y ->strong-fence Z ->hb* F,
+	E ->coe W ->cumul-fence* X ->rfe? Y ->strong-order Z ->hb* F,
 
 where the * suffix indicates an arbitrary number of links of the
 specified type, and the ? suffix indicates the link is optional (Y may
 be equal to X).  Because of the cumul-fence links, we know that W will
 propagate to Y's CPU before X does, hence before Y executes and hence
-before the strong fence executes.  Because this fence is strong, we
-know that W will propagate to every CPU and to RAM before Z executes.
-And because of the hb links, we know that Z will execute before F.
-Thus W, which comes later than E in the coherence order, will
-propagate to every CPU and to RAM before F executes.
+before the strong ordering operation executes.  Because of the strong
+ordering, we know that W will propagate to every CPU and to RAM before
+Z executes.  And because of the hb links, we know that Z will execute
+before F.  Thus W, which comes later than E in the coherence order,
+will propagate to every CPU and to RAM before F executes.
 
 The case where E is a load is exactly the same, except that the first
 link in the sequence is fre instead of coe.
@@ -1637,8 +1667,8 @@ does not imply X ->rcu-order V, because the sequence contains only
 one rcu-gp link but two rcu-rscsi links.
 
 The rcu-order relation is important because the Grace Period Guarantee
-means that rcu-order links act kind of like strong fences.  In
-particular, E ->rcu-order F implies not only that E begins before F
+means that rcu-order links act kind of like a strong ordering operation.
+In particular, E ->rcu-order F implies not only that E begins before F
 ends, but also that any write po-before E will propagate to every CPU
 before any instruction po-after F can execute.  (However, it does not
 imply that E must execute before F; in fact, each synchronize_rcu()
@@ -1675,24 +1705,23 @@ The rcu-fence relation is a simple extension of rcu-order.  While
 rcu-order only links certain fence events (calls to synchronize_rcu(),
 rcu_read_lock(), or rcu_read_unlock()), rcu-fence links any events
 that are separated by an rcu-order link.  This is analogous to the way
-the strong-fence relation links events that are separated by an
+the strong-order relation links events that are separated by an
 smp_mb() fence event (as mentioned above, rcu-order links act kind of
-like strong fences).  Written symbolically, X ->rcu-fence Y means
-there are fence events E and F such that:
+like strong ordering operations).  Written symbolically, X ->rcu-fence Y
+means there are fence events E and F such that:
 
 	X ->po E ->rcu-order F ->po Y.
 
 From the discussion above, we see this implies not only that X
 executes before Y, but also (if X is a store) that X propagates to
-every CPU before Y executes.  Thus rcu-fence is sort of a
-"super-strong" fence: Unlike the original strong fences (smp_mb() and
+every CPU before Y executes.  Thus unlike strong fences (smp_mb() and
 synchronize_rcu()), rcu-fence is able to link events on different
 CPUs.  (Perhaps this fact should lead us to say that rcu-fence isn't
 really a fence at all!)
 
 Finally, the LKMM defines the RCU-before (rb) relation in terms of
 rcu-fence.  This is done in essentially the same way as the pb
-relation was defined in terms of strong-fence.  We will omit the
+relation was defined in terms of strong-order.  We will omit the
 details; the end result is that E ->rb F implies E must execute
 before F, just as E ->pb F does (and for much the same reasons).
 
@@ -2134,7 +2163,7 @@ intermediate event Z such that:
 
 and either:
 
-	Z is connected to Y by a strong-fence link followed by a
+	Z is connected to Y by a strong-order link followed by a
 	possibly empty sequence of xb links,
 
 or:
@@ -2153,10 +2182,10 @@ The motivations behind this definition are straightforward:
 	from W, which certainly means that W must have propagated to
 	R's CPU before R executed.
 
-	strong-fence memory barriers force stores that are po-before
-	the barrier, or that propagate to the barrier's CPU before the
-	barrier executes, to propagate to all CPUs before any events
-	po-after the barrier can execute.
+	Strong ordering operations force stores that are po-before
+	the operation or that propagate to the CPU that begins the
+	operation before the operation executes, to propagate to all
+	CPUs before any events po-after the operation execute.
 
 To see how this works out in practice, consider our old friend, the MP
 pattern (with fences and statement labels, but without the conditional
@@ -2485,7 +2514,7 @@ sequence or if W can be linked to R by a
 sequence.  For the cases involving a vis link, the LKMM also accepts
 sequences in which W is linked to W' or R by a
 
-	strong-fence ; xb* ; {w and/or r}-pre-bounded
+	strong-order ; xb* ; {w and/or r}-pre-bounded
 
 sequence with no post-bounding, and in every case the LKMM also allows
 the link simply to be a fence with no bounding at all.  If no sequence
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 07f884f9b2bf..1d91edbc10fe 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -36,9 +36,7 @@ let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
-	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
-	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
-		fencerel(After-unlock-lock) ; [M])
+	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
 let gp = po ; [Sync-rcu | Sync-srcu] ; po?
 let strong-fence = mb | gp
 
@@ -91,8 +89,12 @@ acyclic hb as happens-before
 (* Write and fence propagation ordering *)
 (****************************************)
 
-(* Propagation: Each non-rf link needs a strong fence. *)
-let pb = prop ; strong-fence ; hb* ; [Marked]
+(* Strong ordering operations *)
+let strong-order = strong-fence | ([M] ; po-unlock-lock-po ;
+		[After-unlock-lock] ; po ; [M])
+
+(* Propagation: Each non-rf link needs a strong ordering operation. *)
+let pb = prop ; strong-order ; hb* ; [Marked]
 acyclic pb as propagation
 
 (*******)
@@ -141,7 +143,7 @@ let rec rcu-order = rcu-gp | srcu-gp |
 	(rcu-order ; rcu-link ; rcu-order)
 let rcu-fence = po ; rcu-order ; po?
 let fence = fence | rcu-fence
-let strong-fence = strong-fence | rcu-fence
+let strong-order = strong-order | rcu-fence
 
 (* rb orders instructions just as pb does *)
 let rb = prop ; rcu-fence ; hb* ; pb* ; [Marked]
@@ -169,7 +171,7 @@ flag ~empty mixed-accesses as mixed-accesses
 (* Executes-before and visibility *)
 let xbstar = (hb | pb | rb)*
 let vis = cumul-fence* ; rfe? ; [Marked] ;
-	((strong-fence ; [Marked] ; xbstar) | (xbstar & int))
+	((strong-order ; [Marked] ; xbstar) | (xbstar & int))
 
 (* Boundaries for lifetimes of plain accesses *)
 let w-pre-bounded = [Marked] ; (addr | fence)?
@@ -180,9 +182,9 @@ let r-post-bounded = (nonrw-fence | ([~Noreturn] ; fencerel(Rmb) ; [R4rmb]))? ;
 	[Marked]
 
 (* Visibility and executes-before for plain accesses *)
-let ww-vis = fence | (strong-fence ; xbstar ; w-pre-bounded) |
+let ww-vis = fence | (strong-order ; xbstar ; w-pre-bounded) |
 	(w-post-bounded ; vis ; w-pre-bounded)
-let wr-vis = fence | (strong-fence ; xbstar ; r-pre-bounded) |
+let wr-vis = fence | (strong-order ; xbstar ; r-pre-bounded) |
 	(w-post-bounded ; vis ; r-pre-bounded)
 let rw-xbstar = fence | (r-post-bounded ; xbstar ; w-pre-bounded)
 
-- 
2.17.1

