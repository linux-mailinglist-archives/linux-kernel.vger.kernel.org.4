Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116A474CE5A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjGJH2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGJH2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:28:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E50AEC;
        Mon, 10 Jul 2023 00:28:30 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A7MZgX006257;
        Mon, 10 Jul 2023 07:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=IIVbNm70ilZCkUbp/iQj0rFzl6EWpboLhrIAQ60lx2M=;
 b=gE7VMqP6gyWIjaDstNtDtyySNeiuBUFuCK2hdAE6R/zn8Y7jpB8gH5UgyXAcP/29i8IO
 7kg/XD0nIEA6ZNVZEmLISK/yKYjOLMMmuLWovm0WGADvm5+B7SiGqDhp48e5jqRmFWJP
 H9EO++7uYgC8DK7rRteOq9bFkOA9JX6S2JE7Ag9oFH5qPhMrQt6p6WRhrSsPJ74MQuaz
 9dXXzTgd+fsm9SY6cXxnh80i+TpkAhsE1UsFlMv7PJY8sla6IijAnRUBFuZvdpmfmObd
 ugNhl9iifRqj20BiP8mcnVdNjdrKWwCuyFDwzMeZ6TI5rZvEoAWVAL3ne5IkD5aU2kWJ 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rrdhp03mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 07:28:28 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36A7MmDD007239;
        Mon, 10 Jul 2023 07:28:27 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rrdhp03kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 07:28:27 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36A4wgJe023419;
        Mon, 10 Jul 2023 07:28:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rpye50t4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 07:28:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36A7SLgZ19727028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 07:28:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A50120043;
        Mon, 10 Jul 2023 07:28:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9825720040;
        Mon, 10 Jul 2023 07:28:20 +0000 (GMT)
Received: from [9.171.92.205] (unknown [9.171.92.205])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jul 2023 07:28:20 +0000 (GMT)
Message-ID: <df5fe3d295711666bf170d35f5196fe7b880342b.camel@linux.ibm.com>
Subject: Re: [PATCH net v2 1/3] s390/ism: Fix locking for forwarding of IRQs
 and events to clients
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 10 Jul 2023 09:28:20 +0200
In-Reply-To: <ZKlmeDUEZf7F8+HW@corigine.com>
References: <20230707104359.3324039-1-schnelle@linux.ibm.com>
         <20230707104359.3324039-2-schnelle@linux.ibm.com>
         <ZKlmeDUEZf7F8+HW@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kPPOZgAY4A3XDD71YHTwOpORGVsTC3tX
X-Proofpoint-ORIG-GUID: IQN94oqGDifqOWM75ocf360o29wtmBit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_05,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=399 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 spamscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307100064
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-07-08 at 14:36 +0100, Simon Horman wrote:
> On Fri, Jul 07, 2023 at 12:43:57PM +0200, Niklas Schnelle wrote:
> > The clients array references all registered clients and is protected by
> > the clients_lock. Besides its use as general list of clients the client=
s
> > array is accessed in ism_handle_irq() to forward ISM device events to
> > clients.
> >=20
> > While the clients_lock is taken in the IRQ handler when calling
> > handle_event() it is however incorrectly not held during the
> > client->handle_irq() call and for the preceding clients[] access leavin=
g
> > it unprotected against concurrent client (un-)registration.
> >=20
> > Furthermore the accesses to ism->sba_client_arr[] in ism_register_dmb()
> > and ism_unregister_dmb() are not protected by any lock. This is
> > especially problematic as the client ID from the ism->sba_client_arr[]
> > is not checked against NO_CLIENT and neither is the client pointer
> > checked.
> >=20
> > Instead of expanding the use of the clients_lock further add a separate
> > array in struct ism_dev which references clients subscribed to the
> > device's events and IRQs. This array is protected by ism->lock which is
> > already taken in ism_handle_irq() and can be taken outside the IRQ
> > handler when adding/removing subscribers or the accessing
> > ism->sba_client_arr[]. This also means that the clients_lock is no
> > longer taken in IRQ context.
> >=20
> > Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> ...
>=20
> > @@ -71,6 +80,7 @@ int ism_register_client(struct ism_client *client)
> >  		list_for_each_entry(ism, &ism_dev_list.list, list) {
> >  			ism->priv[i] =3D NULL;
> >  			client->add(ism);
> > +			ism_setup_forwarding(client, ism);
> >  		}
> >  	}
> >  	mutex_unlock(&ism_dev_list.mutex);
>=20
> ...
>=20
> > @@ -92,6 +102,9 @@ int ism_unregister_client(struct ism_client *client)
> >  		max_client--;
> >  	spin_unlock_irqrestore(&clients_lock, flags);
> >  	list_for_each_entry(ism, &ism_dev_list.list, list) {
> > +		spin_lock_irqsave(&ism->lock, flags);
>=20
> Hi Niklas,
>=20
> The lock is taken here.
>=20
> > +		/* Stop forwarding IRQs and events */
> > +		ism->subs[client->id] =3D NULL;
> >  		for (int i =3D 0; i < ISM_NR_DMBS; ++i) {
> >  			if (ism->sba_client_arr[i] =3D=3D client->id) {
> >  				pr_err("%s: attempt to unregister client '%s'"
> > @@ -101,6 +114,7 @@ int ism_unregister_client(struct ism_client *client=
)
> >  				goto out;
>=20
> But it does not appear to be released
> (by the call to spin_unlock_irqrestore() below)
> if goto out is called here.

Good catch. Yes I screwed this up while splitting the patch up. The
spin_unlock_irqrestore() is there after patch 3 but should have been
added in patch 1. As far as I can see all 3 patches have already been
applied, otherwise I'd send a v3. Thankfully even in the in between
state this error case can really onlt happen due to driver bugs so
maybe it's okay?

>=20
> >  			}
> >  		}
> > +		spin_unlock_irqrestore(&ism->lock, flags);
> >  	}
> >  out:
> >  	mutex_unlock(&ism_dev_list.mutex);

