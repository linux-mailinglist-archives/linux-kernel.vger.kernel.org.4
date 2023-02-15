Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F32697359
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjBOBRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjBOBRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:17:11 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318993250A;
        Tue, 14 Feb 2023 17:16:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGgCD3CVDz4x1T;
        Wed, 15 Feb 2023 12:16:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676423801;
        bh=/Iweysw8OL5zTAF11v5k2tKe0GxUVaT0VWSOuzw0sdE=;
        h=Date:From:To:Cc:Subject:From;
        b=rlIDdTAb6xD/3xP9PBMYmsw+CXYdPb3+IPN6aEv5phA/88MS5lQ3N9946ZSDl9pq2
         6Zaedh1ozeYz/xlxOrE9WAHP2CBqWodevxInLRDAAo3dPHXIdDyR8mV4kMIdhQcEPD
         PE9hxr9OTrTl0cUG/epD62opjCp9tPWCSUgNmeHbQNyEDDmWulPqzJOP0tHel0vK5G
         E6h39+JOA+WrUu293/zJbIfuycXrGFPp9Yt5TT6v0cwlCIRzEzEM2ktWerrW3d9vN8
         r1fJqsT+ZzlvRj5ZnSxn/RDWhq78E3idZ45Dw6yvwffp1FksOTkvV73Y8X9ie7k4pY
         dH4o0nwL8vCDQ==
Date:   Wed, 15 Feb 2023 12:16:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Ross Zwisler <zwisler@google.com>
Subject: linux-next: manual merge of the ftrace tree with the jc_docs tree
Message-ID: <20230215121638.1e86ffa1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vf4F+nlF_6fIoe8yZuFZq2D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vf4F+nlF_6fIoe8yZuFZq2D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ftrace tree got a conflict in:

  Documentation/trace/histogram.rst

between commit:

  2abfcd293b79 ("docs: ftrace: always use canonical ftrace path")

from the jc_docs tree and commit:

  a2ff84a5d1e6 ("tracing/histogram: Wrap remaining shell snippets in code b=
locks")

from the ftrace tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/trace/histogram.rst
index 7b7e4893b8f6,8e95295e39b6..000000000000
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@@ -1861,9 -1864,9 +1864,9 @@@ A histogram can now be defined for the=20
  The above shows the latency "lat" in a power of 2 grouping.
 =20
  Like any other event, once a histogram is enabled for the event, the
- output can be displayed by reading the event's 'hist' file.
+ output can be displayed by reading the event's 'hist' file::
 =20
 -  # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist
 +  # cat /sys/kernel/tracing/events/synthetic/wakeup_latency/hist
 =20
    # event histogram
    #
@@@ -1908,10 -1911,10 +1911,10 @@@
 =20
 =20
  The latency values can also be grouped linearly by a given size with
- the ".buckets" modifier and specify a size (in this case groups of 10).
+ the ".buckets" modifier and specify a size (in this case groups of 10)::
 =20
    # echo 'hist:keys=3Dpid,prio,lat.buckets=3D10:sort=3Dlat' >> \
 -        /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
 +        /sys/kernel/tracing/events/synthetic/wakeup_latency/trigger
 =20
    # event histogram
    #
@@@ -2052,13 -2182,13 +2182,13 @@@ The following commonly-used handler.act
 =20
        # echo 'hist:keys=3D$testpid:testpid=3Dpid:onmatch(sched.sched_wake=
up_new).\
                wakeup_new_test($testpid) if comm=3D=3D"cyclictest"' >> \
 -              /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/tri=
gger
 +              /sys/kernel/tracing/events/sched/sched_wakeup_new/trigger
 =20
-     Or, equivalently, using the 'trace' keyword syntax:
+     Or, equivalently, using the 'trace' keyword syntax::
 =20
-     # echo 'hist:keys=3D$testpid:testpid=3Dpid:onmatch(sched.sched_wakeup=
_new).\
-             trace(wakeup_new_test,$testpid) if comm=3D=3D"cyclictest"' >>=
 \
-             /sys/kernel/tracing/events/sched/sched_wakeup_new/trigger
+       # echo 'hist:keys=3D$testpid:testpid=3Dpid:onmatch(sched.sched_wake=
up_new).\
+               trace(wakeup_new_test,$testpid) if comm=3D=3D"cyclictest"' =
>> \
 -              /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/tri=
gger
++              /sys/kernel/tracing/events/sched/sched_wakeup_new/trigger
 =20
      Creating and displaying a histogram based on those events is now
      just a matter of using the fields and new synthetic event in the
@@@ -2191,48 -2321,48 +2321,48 @@@
      resulting latency, stored in wakeup_lat, exceeds the current
      maximum latency, a snapshot is taken.  As part of the setup, all
      the scheduler events are also enabled, which are the events that
-     will show up in the snapshot when it is taken at some point:
+     will show up in the snapshot when it is taken at some point::
 =20
-     # echo 1 > /sys/kernel/tracing/events/sched/enable
 -      # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
++      # echo 1 > /sys/kernel/tracing/events/sched/enable
 =20
-     # echo 'hist:keys=3Dpid:ts0=3Dcommon_timestamp.usecs \
-             if comm=3D=3D"cyclictest"' >> \
-             /sys/kernel/tracing/events/sched/sched_waking/trigger
+       # echo 'hist:keys=3Dpid:ts0=3Dcommon_timestamp.usecs \
+               if comm=3D=3D"cyclictest"' >> \
 -              /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
++              /sys/kernel/tracing/events/sched/sched_waking/trigger
 =20
-     # echo 'hist:keys=3Dnext_pid:wakeup_lat=3Dcommon_timestamp.usecs-$ts0=
: \
-             onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_pri=
o, \
- 	    prev_comm):onmax($wakeup_lat).snapshot() \
- 	    if next_comm=3D=3D"cyclictest"' >> \
- 	    /sys/kernel/tracing/events/sched/sched_switch/trigger
+       # echo 'hist:keys=3Dnext_pid:wakeup_lat=3Dcommon_timestamp.usecs-$t=
s0: \
+               onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_p=
rio, \
+ 	      prev_comm):onmax($wakeup_lat).snapshot() \
+ 	      if next_comm=3D=3D"cyclictest"' >> \
 -	      /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
++	      /sys/kernel/tracing/events/sched/sched_switch/trigger
 =20
      When the histogram is displayed, for each bucket the max value
      and the saved values corresponding to the max are displayed
      following the rest of the fields.
 =20
      If a snapshot was taken, there is also a message indicating that,
-     along with the value and event that triggered the global maximum:
+     along with the value and event that triggered the global maximum::
 =20
-     # cat /sys/kernel/tracing/events/sched/sched_switch/hist
-       { next_pid:       2101 } hitcount:        200
- 	max:         52  next_prio:        120  next_comm: cyclictest \
-         prev_pid:          0  prev_prio:        120  prev_comm: swapper/6
 -      # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
++      # cat /sys/kernel/tracing/events/sched/sched_switch/hist
+         { next_pid:       2101 } hitcount:        200
+ 	  max:         52  next_prio:        120  next_comm: cyclictest \
+           prev_pid:          0  prev_prio:        120  prev_comm: swapper=
/6
 =20
-       { next_pid:       2103 } hitcount:       1326
- 	max:        572  next_prio:         19  next_comm: cyclictest \
-         prev_pid:          0  prev_prio:        120  prev_comm: swapper/1
+         { next_pid:       2103 } hitcount:       1326
+ 	  max:        572  next_prio:         19  next_comm: cyclictest \
+           prev_pid:          0  prev_prio:        120  prev_comm: swapper=
/1
 =20
-       { next_pid:       2102 } hitcount:       1982 \
- 	max:         74  next_prio:         19  next_comm: cyclictest \
-         prev_pid:          0  prev_prio:        120  prev_comm: swapper/5
+         { next_pid:       2102 } hitcount:       1982 \
+ 	  max:         74  next_prio:         19  next_comm: cyclictest \
+           prev_pid:          0  prev_prio:        120  prev_comm: swapper=
/5
 =20
-     Snapshot taken (see tracing/snapshot).  Details:
- 	triggering value { onmax($wakeup_lat) }:        572	\
- 	triggered by event with key: { next_pid:       2103 }
+       Snapshot taken (see tracing/snapshot).  Details:
+ 	  triggering value { onmax($wakeup_lat) }:        572	\
+ 	  triggered by event with key: { next_pid:       2103 }
 =20
-     Totals:
-         Hits: 3508
-         Entries: 3
-         Dropped: 0
+       Totals:
+           Hits: 3508
+           Entries: 3
+           Dropped: 0
 =20
      In the above case, the event that triggered the global maximum has
      the key with next_pid =3D=3D 2103.  If you look at the bucket that has
@@@ -2310,15 -2440,15 +2440,15 @@@
      $cwnd variable.  If the value has changed, a snapshot is taken.
      As part of the setup, all the scheduler and tcp events are also
      enabled, which are the events that will show up in the snapshot
-     when it is taken at some point:
+     when it is taken at some point::
 =20
-     # echo 1 > /sys/kernel/tracing/events/sched/enable
-     # echo 1 > /sys/kernel/tracing/events/tcp/enable
 -      # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
 -      # echo 1 > /sys/kernel/debug/tracing/events/tcp/enable
++      # echo 1 > /sys/kernel/tracing/events/sched/enable
++      # echo 1 > /sys/kernel/tracing/events/tcp/enable
 =20
-     # echo 'hist:keys=3Ddport:cwnd=3Dsnd_cwnd: \
-             onchange($cwnd).save(snd_wnd,srtt,rcv_wnd): \
- 	    onchange($cwnd).snapshot()' >> \
- 	    /sys/kernel/tracing/events/tcp/tcp_probe/trigger
+       # echo 'hist:keys=3Ddport:cwnd=3Dsnd_cwnd: \
+               onchange($cwnd).save(snd_wnd,srtt,rcv_wnd): \
+ 	      onchange($cwnd).snapshot()' >> \
 -	      /sys/kernel/debug/tracing/events/tcp/tcp_probe/trigger
++	      /sys/kernel/tracing/events/tcp/tcp_probe/trigger
 =20
      When the histogram is displayed, for each bucket the tracked value
      and the saved values corresponding to that value are displayed

--Sig_/vf4F+nlF_6fIoe8yZuFZq2D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPsMnYACgkQAVBC80lX
0GzxTQf/a5xtAAr8S2o2F8mhvcz7XJWitC8hA6nnLoz9gL9yDjyg8oYH6oMhUIQZ
omq3VQptfFwfMZy28R8/NIjusbdalCUWIVy+HC/RMG0wqF9TdyYpFS4CgmfBjnkr
J/fsvK9+5/Jmt0VecHMQiwPxW6ILG39CsdTFKqXKVBR3flVSe7F0uuX51K+4rtA8
k7F//CKhOXueqs1W5516Ylk9jEatmCB9U9u4O3Wk388GUavj3uFqfnYFVf9MAkYM
jj/DL7vVGRmQcelT6cj0jOUyhnybpGrLflxXL9xlRquPRJhnr0suTyMCz+tfKTpp
DZuD+4+cvr3srUSNgRrYC0SwGp6nnA==
=JwoG
-----END PGP SIGNATURE-----

--Sig_/vf4F+nlF_6fIoe8yZuFZq2D--
