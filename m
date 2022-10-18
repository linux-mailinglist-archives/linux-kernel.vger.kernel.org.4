Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD52602973
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJRKhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJRKhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:37:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2457B44A7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:37:29 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IAaxcr001598;
        Tue, 18 Oct 2022 10:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=NOFfoRXkL3kE9+iDMAHolLK0titndQTyTxNQkNL82pw=;
 b=KpG6HBZez8EWnBN6AuQVbbIe/3GddJuTFMWSrG9d7xjWmMqI3jXXlMqq9/hB3zrFoFQ7
 qcaVbdMH6VWjW7GSxqqPp1UrfVV1e2lDTpFM4mRP83r18wwhJym4cmK0mLGhiCgPpgrO
 kDCRfgVedD19NoXXSlKY5aLlHVZsHd7ZvS4dGhvfvULtCNEuH1b3wSl+jnmJ5oLPdZU6
 dFFawRbe5PX0X+bs5ghDObw/vy3Hl9mySg4Vd+6PGECKLohTPdEiNjMGpp7Pvau5Pxce
 MlEBki/ofNhlwDfjBJ310RJ3wVJPNLNkOD1adJ64dUv2LsRUms5KLtn91hIaUYw1Odlk Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9sjgj41v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 10:37:19 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29IAb518002344;
        Tue, 18 Oct 2022 10:37:18 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9sjgj418-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 10:37:18 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29IAZZWY024870;
        Tue, 18 Oct 2022 10:37:16 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3k7m4jburq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 10:37:15 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29IAbCJn41943426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 10:37:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 875814C04E;
        Tue, 18 Oct 2022 10:37:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF92E4C050;
        Tue, 18 Oct 2022 10:37:09 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com (unknown [9.204.207.240])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Oct 2022 10:37:09 +0000 (GMT)
Date:   Tue, 18 Oct 2022 16:07:06 +0530
From:   Vishal Chourasia <vishalc@linux.vnet.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com,
        aneesh.kumar@linux.ibm.com
Subject: Re: sched/debug: CPU hotplug operation suffers in a large cpu systems
Message-ID: <Y06B0pr8hpwzxEzI@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
References: <Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y01kc4g9CVmoyOxj@hirez.programming.kicks-ass.net>
 <Y01sk3l8yCMvhvYm@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0Qu2bo5zqLn/u1m+"
Content-Disposition: inline
In-Reply-To: <Y01sk3l8yCMvhvYm@kroah.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XIDfor_7OlSQeHQ8sAifli-s4biV_jbr
X-Proofpoint-GUID: 1su56CA_Ixl66T6Y8Su44ZD9a3Rckwhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_03,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0Qu2bo5zqLn/u1m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2022 at 04:54:11PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 17, 2022 at 04:19:31PM +0200, Peter Zijlstra wrote:
> >=20
> > +GregKH who actually knows about debugfs.
> >=20
> > On Mon, Oct 17, 2022 at 06:40:49PM +0530, Vishal Chourasia wrote:
> > > smt=3Doff operation on system with 1920 CPUs is taking approx 59 mins=
 on v5.14
> > > versus 29 mins on v5.11 measured using:
> > > # time ppc64_cpu --smt=3Doff
> > >=20
> > >=20
> > > |--------------------------------+----------------+--------------|
> > > | method                         | sysctl         | debugfs      |
> > > |--------------------------------+----------------+--------------|
> > > | unregister_sysctl_table        |   0.020050 s   | NA           |
> > > | build_sched_domains            |   3.090563 s   | 3.119130 s   |
> > > | register_sched_domain_sysctl   |   0.065487 s   | NA           |
> > > | update_sched_domain_debugfs    |   NA           | 2.791232 s   |
> > > | partition_sched_domains_locked |   3.195958 s   | 5.933254 s   |
> > > |--------------------------------+----------------+--------------|
> > >=20
> > > Note: partition_sched_domains_locked internally calls build_sched_dom=
ains
> > >       and calls other functions respective to what's being currently =
used to
> > >       export information i.e. sysctl or debugfs
> > >=20
> > > Above numbers are quoted from the case where we tried offlining 1 cpu=
 in system
> > > with 1920 online cpus.
> > >=20
> > > From the above table, register_sched_domain_sysctl and
> > > unregister_sysctl_table collectively took ~0.085 secs, whereas
> > > update_sched_domain_debugfs took ~2.79 secs.=20
> > >=20
> > > Root cause:
> > >=20
> > > The observed regression stems from the way these two pseudo-filesyste=
ms handle
> > > creation and deletion of files and directories internally. =20
>=20
> Yes, debugfs is not optimized for speed or memory usage at all.  This
> happens to be the first code path I have seen that cares about this for
> debugfs files.
>=20
> You can either work on not creating so many debugfs files (do you really
> really need all of them all the time?)  Or you can work on moving
> debugfs to use kernfs as the backend logic, which will save you both
> speed and memory usage overall as kernfs is used to being used on
> semi-fast paths.
>=20
> Maybe do both?
>=20
> hope this helps,
>=20
> greg k-h

Yes, we need to create 7-8 files per domain per CPU, eventually ending up
creating a lot of files.=20

Peter,

Is there a possibility of reverting back to /proc/sys/kernel/sched_domain/?

-- vishal.c
--0Qu2bo5zqLn/u1m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyetz6oh8pzQ87ZNz8y5vG2Pik+wFAmNOgckACgkQ8y5vG2Pi
k+xz2Qf/X4AlvD5n6mhCcbKCJEHkY98TzePFXsauS/vcCWp54fgypxV+sm4Q5acx
5h/RGcfNwzAO1PZ2GgNBBNIfCyPTXiSZM68PpYLTZaXNV1ycy4W9SX59NKxTGMgt
LtC9U/QeMKvsHAHp0Ih80+P5m62XZCmW48bRbxLapIpcGHb/xZGTVVheKP6qlfAm
J+yCXMhcccfX+7HwC9HPbtdwVygUhXy4X0WWKhzFJC2RHdt9mtsA39pMRIXZh0oz
PmTGmQHTX5WLXJn5PeDY4DKP6nsxZ3CFjsTgHlri4GjKIVwrUsPxYW+yhhfqk8Tg
MzlORppNPgysB0sV46mSFhaGjcgqww==
=kFDe
-----END PGP SIGNATURE-----

--0Qu2bo5zqLn/u1m+--

