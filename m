Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9397D620CC8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiKHKBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiKHKBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:01:16 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6BE2B24F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:01:14 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A89SSnP025369;
        Tue, 8 Nov 2022 10:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=7iB60qJUvL4Ren5jwx4wWRI4fo2YZAcZYJ+1rXNr2g8=;
 b=jYAqvmmHDiN67EARPe1M9nr66bA/ZVdNM4VWuYVl5979oeamRwwopmyF/fC3TkY+znzz
 JRrWrVhyA/8WqAGUGv2vWB1CcIvMXu4q87LvxXsNdUGxZCxNOXm/TsWuuljO80/GwhJJ
 G0p/zymXHvxFGBZwYkzolzRkXT2XP3ecYNVa79HdYJsqpyT3kN9RyWAD2bfagH5boOIj
 uewylOH0QArJR9xG/SNHmucp0UZSBvPni8AZnD8j4hA6ejGYFp9ZW3wIwbxy9FVEoKCO
 1pJm+jpPgjs9Jr4QeclstGTyeIQ8VtTiLvVMDq4Z5mkFdhS8EC2YCMJjxvfMIRLD32mj RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kqkmx2hb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 10:00:57 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A89rwWa014216;
        Tue, 8 Nov 2022 10:00:56 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kqkmx2ha4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 10:00:56 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A89oP98010000;
        Tue, 8 Nov 2022 10:00:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3kngp5jtr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 10:00:54 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A8A0pJ02491130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Nov 2022 10:00:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D82FA4055;
        Tue,  8 Nov 2022 10:00:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF8DFA4053;
        Tue,  8 Nov 2022 10:00:48 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com (unknown [9.204.207.240])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Nov 2022 10:00:48 +0000 (GMT)
Date:   Tue, 8 Nov 2022 15:30:46 +0530
From:   Vishal Chourasia <vishalc@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com,
        aneesh.kumar@linux.ibm.com
Subject: Re: sched/debug: CPU hotplug operation suffers in a large cpu systems
Message-ID: <Y2oozs/YgqqRV5hq@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
References: <Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y01kc4g9CVmoyOxj@hirez.programming.kicks-ass.net>
 <Y01sk3l8yCMvhvYm@kroah.com>
 <Y06B0pr8hpwzxEzI@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y06ISBWhJflnV+NI@kroah.com>
 <Y1jVjX9FUuUilcjA@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y1jbhCYfktL51zNB@kroah.com>
 <Y1j5cqbyZCDlyaTn@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UBpU2kI7vuMERruO"
Content-Disposition: inline
In-Reply-To: <Y1j5cqbyZCDlyaTn@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uUo2UJkkFOI1n3ZZkVZmmpoWRPKICybp
X-Proofpoint-ORIG-GUID: ghyKGEPRvZc5JBabE61avI6_p-ueX0mL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UBpU2kI7vuMERruO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Thanks Greg & Peter for your direction.=20

While we pursue the idea of having debugfs based on kernfs, we thought about
having a boot time parameter which would disable creating and updating of t=
he
sched_domain debugfs files and this would also be useful even when the kern=
fs
solution kicks in, as users who may not care about these debugfs files would
benefit from a faster CPU hotplug operation.

However, these sched_domain debugfs files are created by default.

-- vishal.c

------>8-----------------------------------------------------8<------------=
--

=46rom f66f66ee05a9f719b58822d13e501d65391dd9d3 Mon Sep 17 00:00:00 2001
=46rom: Vishal Chourasia <vishalc@linux.vnet.ibm.com>
Date: Tue, 8 Nov 2022 14:21:15 +0530
Subject: [PATCH] Add kernel parameter to disable creation of sched_domain
 files

For large systems, creation of sched_domain debug files takes unusually long
time. In which case, sched_sd_export can be passed as kernel command line
parameter during boot time to prevent kernel from creating sched_domain fil=
es.

This commit adds a kernel command line parameter, sched_sd_export, which ca=
n be
used to, optionally, disable the creation of sched_domain debug files.=20
---
 kernel/sched/debug.c    |  9 ++++++---
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c | 11 ++++++++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index bb3d63bdf4ae..bd307847b76a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -279,6 +279,7 @@ static const struct file_operations sched_dynamic_fops =
=3D {
 #endif /* CONFIG_PREEMPT_DYNAMIC */
=20
 __read_mostly bool sched_debug_verbose;
+__read_mostly int sched_debug_export =3D 1;
=20
 static const struct seq_operations sched_debug_sops;
=20
@@ -321,9 +322,11 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sche=
d_migration_cost);
 	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_mi=
grate);
=20
-	mutex_lock(&sched_domains_mutex);
-	update_sched_domain_debugfs();
-	mutex_unlock(&sched_domains_mutex);
+	if (likely(sched_debug_export)) {
+		mutex_lock(&sched_domains_mutex);
+		update_sched_domain_debugfs();
+		mutex_unlock(&sched_domains_mutex);
+	}
 #endif
=20
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e26688d387ae..a4d06588d876 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2738,6 +2738,7 @@ extern struct sched_entity *__pick_last_entity(struct=
 cfs_rq *cfs_rq);
=20
 #ifdef	CONFIG_SCHED_DEBUG
 extern bool sched_debug_verbose;
+extern int sched_debug_export;
=20
 extern void print_cfs_stats(struct seq_file *m, int cpu);
 extern void print_rt_stats(struct seq_file *m, int cpu);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..7bcdbc2f856d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -19,6 +19,13 @@ static int __init sched_debug_setup(char *str)
 }
 early_param("sched_verbose", sched_debug_setup);
=20
+static int __init sched_debug_disable_export(char *str)
+{
+	sched_debug_export =3D 0;
+	return 0;
+}
+early_param("sched_sd_export", sched_debug_disable_export);
+
 static inline bool sched_debug(void)
 {
 	return sched_debug_verbose;
@@ -152,6 +159,7 @@ static void sched_domain_debug(struct sched_domain *sd,=
 int cpu)
 #else /* !CONFIG_SCHED_DEBUG */
=20
 # define sched_debug_verbose 0
+# define sched_debug_export 1
 # define sched_domain_debug(sd, cpu) do { } while (0)
 static inline bool sched_debug(void)
 {
@@ -2632,7 +2640,8 @@ void partition_sched_domains_locked(int ndoms_new, cp=
umask_var_t doms_new[],
 	dattr_cur =3D dattr_new;
 	ndoms_cur =3D ndoms_new;
=20
-	update_sched_domain_debugfs();
+	if (likely(sched_debug_export))
+		update_sched_domain_debugfs();
 }
=20
 /*

base-commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
--=20
2.31.1

 =20

--UBpU2kI7vuMERruO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyetz6oh8pzQ87ZNz8y5vG2Pik+wFAmNqKMIACgkQ8y5vG2Pi
k+xZTgf+O4+TVrSssEu9R1VM/1n9SjLRJkgmuRNOKW0mIxLPcZ55qWYN0kD/4Mb+
jUnHWFPF1X5yC1E3ntmd6sEa2wNbkBF76CH1BMavTU8cvwhcZ34GuJtGp6MYaJ6s
xNGbtxzcRuSVosPW1FloESNhlYmL0x8jXySEYoaAHkyW1teBwvfg6lEAPMeEaUkT
DasNW8FWw0MfjwVtj9lf1k7XAUutQRG3f/Jcmpc7lmYAHfZcbxldBDuTJTdNo62S
k09BYcMI1+0zR1sX7pM9nciPVrWFblfmxyiVlXBNqKeDyl+dBxkKaGP5iW0QLlFS
nTttuQ73QeT8/FRlsWbxwTUsYzzRqQ==
=JIfg
-----END PGP SIGNATURE-----

--UBpU2kI7vuMERruO--

