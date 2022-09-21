Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CAB5C0491
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiIUQsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiIUQrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:47:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404156B163;
        Wed, 21 Sep 2022 09:39:59 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LG8X9M030229;
        Wed, 21 Sep 2022 16:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=qcppdkim1;
 bh=hioFZkLtJIWgIGuSUmHhlWfdR6f1ZV4m1eO86vZeKYI=;
 b=E/Bx4SI8GBu/H1VAMs5HPNu9uLgIRUS3+StBevYA7Vw8vkW/uBK6ciuQwih74DAizKz7
 OO6m82ySBImybTJ+oTBWc2y2q98C37SPjKUC7TK4nN9XS4Wp8oA1HEkor8smj+FpsTm0
 6FQHasLDx7Nw4j2YHWvY4YQvNzKDzG/+1pWqegphzlP+1OvJ1iv470TcYXMGp7AfNkuN
 /zXx9J6fuUnWkQwFa6hDjzsX0axeCo6IgfQE7fAgt7o4CH12H+BRlhtK/UyDrwV9B2gu
 rQPYwCOl8LTMTV0VCtmP+Wp9vSo8UjsTfHe1RvAmSHymviE4PozZQNt9e9OvYSmKzlxt rA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jqx5w9shr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 16:39:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28LGdkKr020536
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 16:39:46 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 21 Sep 2022 09:39:46 -0700
Received: from nalasex01a.na.qualcomm.com ([fe80::e806:55a6:340c:5476]) by
 nalasex01a.na.qualcomm.com ([fe80::e806:55a6:340c:5476%4]) with mapi id
 15.02.0986.029; Wed, 21 Sep 2022 09:39:46 -0700
From:   "Gokul krishna Krishnakumar (QUIC)" <quic_gokukris@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        "Gokul krishna Krishnakumar (QUIC)" <quic_gokukris@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Trilok Soni (QUIC)" <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala (QUIC)" <quic_satyap@quicinc.com>,
        "Rajendra Nayak (QUIC)" <quic_rjendra@quicinc.com>,
        "Elliot Berman (QUIC)" <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh (QUIC)" <quic_gurus@quicinc.com>
Subject: RE: [PATCH v1 2/2] soc: qcom: mdt_loader: Move the memory allocation
 into mdt loader
Thread-Topic: [PATCH v1 2/2] soc: qcom: mdt_loader: Move the memory allocation
 into mdt loader
Thread-Index: AQHYxtdN9YxRFF3aoEC88fI+1p5Akq3eQY4AgAxXmzA=
Date:   Wed, 21 Sep 2022 16:39:46 +0000
Message-ID: <40718b43db8f4702b0dbfec79b6fc8ab@quicinc.com>
References: <cover.1663007783.git.quic_gokukris@quicinc.com>
 <2ba262668e86e58acb086c64fc759ba02b39a525.1663007783.git.quic_gokukris@quicinc.com>
 <20220913201102.mjmtvsx5xyfcr5cw@builder.lan>
In-Reply-To: <20220913201102.mjmtvsx5xyfcr5cw@builder.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.110.42.172]
Content-Type: multipart/mixed;
        boundary="_003_40718b43db8f4702b0dbfec79b6fc8abquicinccom_"
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dKTKyV48eq75zIdqTaT57AmmSUK5tegl
X-Proofpoint-ORIG-GUID: dKTKyV48eq75zIdqTaT57AmmSUK5tegl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_09,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209210113
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_003_40718b43db8f4702b0dbfec79b6fc8abquicinccom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>At the end of this function we invoke kfree(metadata), which would be bad =
if that comes from dma_alloc_coherent().
+       if (mdata_phys) {
+               data =3D dma_alloc_coherent(dev, ehdr_size + hash_size, mda=
ta_phys,
+                                      GFP_KERNEL);
+       } else {
+               data =3D kmalloc(ehdr_size + hash_size, GFP_KERNEL);
Adding dma_alloc_coherent without affecting the mss driver.


> As LKP points out, I don't seem to have this function.
Removing the qcom_get_scm_device() and calling dma_alloc_coherent from devi=
ce context.
+               data =3D dma_alloc_coherent(dev, ehdr_size + hash_size, mda=
ta_phys,
+                                      GFP_KERNEL);

>I am not thrilled about the idea of doing dma_alloc_coherent() in this fil=
e and dma_free_coherent() in the scm driver. Similarly, I consider these fu=
nctions to operate in the context of the caller, so operating on the scm de=
vice's struct device isn't so nice.
>After trying various models I came to the conclusion that it was better to=
 try to keep the MDT loader to just load MDT files, and move the SCM/PAS in=
teraction out of that. Unfortunately we have a number of client drivers tha=
t would then need to (essentially) duplicate the content of qcom_mdt_pas_in=
it() - so I left >that in there.
>I still believe that keeping the MDT loader focused on loading MDTs is a g=
ood idea, but I'm open to any suggestions for improvements in the interacti=
on between these different components.

With this patch we moving all the dma_alloc_coherent() and dma_free_coheren=
t() to the MDT loader.
So now the MDT loader has the functionality of loading and allocating memor=
y
and the SCM driver packs the arguments and makes a call to the secure world=
.

-----Original Message-----
From: Bjorn Andersson <andersson@kernel.org>=20
Sent: Tuesday, September 13, 2022 4:11 PM
To: Gokul krishna Krishnakumar (QUIC) <quic_gokukris@quicinc.com>
Cc: Andy Gross <agross@kernel.org>; Konrad Dybcio <konrad.dybcio@somainline=
.org>; Philipp Zabel <p.zabel@pengutronix.de>; linux-arm-msm@vger.kernel.or=
g; linux-kernel@vger.kernel.org; Trilok Soni (QUIC) <quic_tsoni@quicinc.com=
>; Satya Durga Srinivasu Prabhala (QUIC) <quic_satyap@quicinc.com>; Rajendr=
a Nayak (QUIC) <quic_rjendra@quicinc.com>; Elliot Berman (QUIC) <quic_eberm=
an@quicinc.com>; Guru Das Srinagesh (QUIC) <quic_gurus@quicinc.com>
Subject: Re: [PATCH v1 2/2] soc: qcom: mdt_loader: Move the memory allocati=
on into mdt loader

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

On Mon, Sep 12, 2022 at 11:41:32AM -0700, Gokul krishna Krishnakumar wrote:
> By moving the memory allocation to mdt loader we can simplify the scm=20
> call, by just packing arguments provided to it from the clients for=20
> making secuer world calls. We can also simplify the memory allocation=20
> for the qcom metadata, by just doing one memory allocation in the mdt=20
> loader.
>
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c  |  2 +-
>  drivers/soc/qcom/mdt_loader.c       | 41 ++++++++++++++++++++++++++++---=
------
>  include/linux/soc/qcom/mdt_loader.h |  5 +++--
>  3 files changed, 35 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c=20
> b/drivers/remoteproc/qcom_q6v5_mss.c
> index fddb63c..1919bfc 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -947,7 +947,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, c=
onst struct firmware *fw,
>       int ret;
>       int i;
>
> -     metadata =3D qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev)=
;
> +     metadata =3D qcom_mdt_read_metadata(fw, &size, fw_name,=20
> + qproc->dev, NULL);

At the end of this function we invoke kfree(metadata), which would be bad i=
f that comes from dma_alloc_coherent().

>       if (IS_ERR(metadata))
>               return PTR_ERR(metadata);
>
> diff --git a/drivers/soc/qcom/mdt_loader.c=20
> b/drivers/soc/qcom/mdt_loader.c
[..]
> @@ -160,9 +164,18 @@ void *qcom_mdt_read_metadata(const struct firmware *=
fw, size_t *data_len,
>       ehdr_size =3D phdrs[0].p_filesz;
>       hash_size =3D phdrs[hash_segment].p_filesz;
>
> -     data =3D kmalloc(ehdr_size + hash_size, GFP_KERNEL);
> -     if (!data)
> -             return ERR_PTR(-ENOMEM);
> +     /*
> +      * During the scm call memory protection will be enabled for the me=
ta
> +      * data blob, so make sure it's physically contiguous, 4K aligned a=
nd
> +      * non-cachable to avoid XPU violations.
> +      */
> +     scm_dev =3D qcom_get_scm_device();

As LKP points out, I don't seem to have this function.

> +     data =3D dma_alloc_coherent(scm_dev, ehdr_size + hash_size, mdata_p=
hys,
> +                                    GFP_KERNEL);

I am not thrilled about the idea of doing dma_alloc_coherent() in this file=
 and dma_free_coherent() in the scm driver. Similarly, I consider these fun=
ctions to operate in the context of the caller, so operating on the scm dev=
ice's struct device isn't so nice.


After trying various models I came to the conclusion that it was better to =
try to keep the MDT loader to just load MDT files, and move the SCM/PAS int=
eraction out of that. Unfortunately we have a number of client drivers that=
 would then need to (essentially) duplicate the content of qcom_mdt_pas_ini=
t() - so I left that in there.

I still believe that keeping the MDT loader focused on loading MDTs is a go=
od idea, but I'm open to any suggestions for improvements in the interactio=
n between these different components.

Regards,
Bjorn

--_003_40718b43db8f4702b0dbfec79b6fc8abquicinccom_
Content-Type: application/octet-stream;
	name="v2-0001-firmware-qcom_scm-Remove-memory-alloc-call-from-q.patch"
Content-Description: v2-0001-firmware-qcom_scm-Remove-memory-alloc-call-from-q.patch
Content-Disposition: attachment;
	filename="v2-0001-firmware-qcom_scm-Remove-memory-alloc-call-from-q.patch";
	size=4946; creation-date="Wed, 21 Sep 2022 16:27:42 GMT";
	modification-date="Wed, 21 Sep 2022 16:27:42 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwMTJmODY1YWE5OTUxZjhkYWJkMWExNzk4MGRjNDY4N2FkZWE5NGRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8MDEyZjg2NWFhOTk1MWY4ZGFiZDFhMTc5ODBkYzQ2
ODdhZGVhOTRkYy4xNjYzNzc3NjYyLmdpdC5xdWljX2dva3VrcmlzQHF1aWNpbmMuY29tPgpJbi1S
ZXBseS1UbzogPGNvdmVyLjE2NjM3Nzc2NjIuZ2l0LnF1aWNfZ29rdWtyaXNAcXVpY2luYy5jb20+
ClJlZmVyZW5jZXM6IDxjb3Zlci4xNjYzNzc3NjYyLmdpdC5xdWljX2dva3VrcmlzQHF1aWNpbmMu
Y29tPgpGcm9tOiBHb2t1bCBrcmlzaG5hIEtyaXNobmFrdW1hciA8cXVpY19nb2t1a3Jpc0BxdWlj
aW5jLmNvbT4KRGF0ZTogTW9uLCAxMiBTZXAgMjAyMiAxMTo0MTozMSAtMDcwMApTdWJqZWN0OiBb
UEFUQ0ggdjIgMS8yXSBmaXJtd2FyZTogcWNvbV9zY206IFJlbW92ZSBtZW1vcnkgYWxsb2MgY2Fs
bCBmcm9tCiBxY29tX3NjbV9wYXNfaW5pdF9pbWFnZSgpCgpUaGUgbWVtb3J5IGZvciBtZXRhZGF0
YSBpcyBhbGxvY2F0ZWQgaW4gbWR0IGxvYWRlciBhbmQgc2NtIGRyaXZlcgoKMV0uICAxNjMgIGRh
dGEgPSBrbWFsbG9jKGVoZHJfc2l6ZSArIGhhc2hfc2l6ZSwgR0ZQX0tFUk5FTCk7CjJdLiAgNDc3
ICBtZGF0YV9idWYgPSBkbWFfYWxsb2NfY29oZXJlbnQoX19zY20tPmRldiwgc2l6ZSwgJm1kYXRh
X3BoeXMsCiAgICAgNDc4ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdG
UF9LRVJORUwpOwoKVGhlIFNDTSBkcml2ZXIgaXMgbWVhbnQgdG8gb25seSBwYWNrIGFyZ3VtZW50
cyBwcm92aWRlZCB0byBpdCBmcm9tIGNsaWVudHMKZm9yIG1ha2luZyB0aGUgc2VjdXJlIHdvcmxk
IGNhbGxzLiBUaGlzIGNoYW5nZSByZW1vdmVzIHRoZSBsb2dpYyBvZiBkb2luZwphIGRtYSBhbGxv
YyBjb2hlcmVudCBmcm9tIHRoZSBTQ00gZHJpdmVyIGFuZCBtb3ZlcyBpdCBpbnRvIHRoZSBtZHQg
bG9hZGVyCgpTaWduZWQtb2ZmLWJ5OiBHb2t1bCBrcmlzaG5hIEtyaXNobmFrdW1hciA8cXVpY19n
b2t1a3Jpc0BxdWljaW5jLmNvbT4KLS0tCiBkcml2ZXJzL2Zpcm13YXJlL3Fjb21fc2NtLmMgICB8
IDMzICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogZHJpdmVycy9zb2MvcWNvbS9t
ZHRfbG9hZGVyLmMgfCAgMyArKy0KIGluY2x1ZGUvbGludXgvcWNvbV9zY20uaCAgICAgIHwgIDQg
Ky0tLQogMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvcWNvbV9zY20uYyBiL2RyaXZlcnMvZmlybXdh
cmUvcWNvbV9zY20uYwppbmRleCBjZGJmZTU0Li4wNWVjMDNjIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2Zpcm13YXJlL3Fjb21fc2NtLmMKKysrIGIvZHJpdmVycy9maXJtd2FyZS9xY29tX3NjbS5jCkBA
IC00NDIsMTEgKzQ0Miw5IEBAIHN0YXRpYyB2b2lkIHFjb21fc2NtX3NldF9kb3dubG9hZF9tb2Rl
KGJvb2wgZW5hYmxlKQogICoJCQkgICAgICAgc3RhdGUgbWFjaGluZSBmb3IgYSBnaXZlbiBwZXJp
cGhlcmFsLCB1c2luZyB0aGUKICAqCQkJICAgICAgIG1ldGFkYXRhCiAgKiBAcGVyaXBoZXJhbDog
cGVyaXBoZXJhbCBpZAotICogQG1ldGFkYXRhOglwb2ludGVyIHRvIG1lbW9yeSBjb250YWluaW5n
IEVMRiBoZWFkZXIsIHByb2dyYW0gaGVhZGVyIHRhYmxlCisgKiBAbWRhdGFfcGh5czoJcG9pbnRl
ciB0byBtZW1vcnkgY29udGFpbmluZyBFTEYgaGVhZGVyLCBwcm9ncmFtIGhlYWRlciB0YWJsZQog
ICoJCWFuZCBvcHRpb25hbCBibG9iIG9mIGRhdGEgdXNlZCBmb3IgYXV0aGVudGljYXRpbmcgdGhl
IG1ldGFkYXRhCiAgKgkJYW5kIHRoZSByZXN0IG9mIHRoZSBmaXJtd2FyZQotICogQHNpemU6CXNp
emUgb2YgdGhlIG1ldGFkYXRhCi0gKiBAY3R4OglvcHRpb25hbCBtZXRhZGF0YSBjb250ZXh0CiAg
KgogICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MuCiAgKgpAQCAtNDU0LDExICs0NTIsOCBAQCBzdGF0
aWMgdm9pZCBxY29tX3NjbV9zZXRfZG93bmxvYWRfbW9kZShib29sIGVuYWJsZSkKICAqIHRyYWNr
IHRoZSBtZXRhZGF0YSBhbGxvY2F0aW9uLCB0aGlzIG5lZWRzIHRvIGJlIHJlbGVhc2VkIGJ5IGlu
dm9raW5nCiAgKiBxY29tX3NjbV9wYXNfbWV0YWRhdGFfcmVsZWFzZSgpIGJ5IHRoZSBjYWxsZXIu
CiAgKi8KLWludCBxY29tX3NjbV9wYXNfaW5pdF9pbWFnZSh1MzIgcGVyaXBoZXJhbCwgY29uc3Qg
dm9pZCAqbWV0YWRhdGEsIHNpemVfdCBzaXplLAotCQkJICAgIHN0cnVjdCBxY29tX3NjbV9wYXNf
bWV0YWRhdGEgKmN0eCkKK2ludCBxY29tX3NjbV9wYXNfaW5pdF9pbWFnZSh1MzIgcGVyaXBoZXJh
bCwgZG1hX2FkZHJfdCBtZGF0YV9waHlzKQogewotCWRtYV9hZGRyX3QgbWRhdGFfcGh5czsKLQl2
b2lkICptZGF0YV9idWY7CiAJaW50IHJldDsKIAlzdHJ1Y3QgcWNvbV9zY21fZGVzYyBkZXNjID0g
ewogCQkuc3ZjID0gUUNPTV9TQ01fU1ZDX1BJTCwKQEAgLTQ2OSwyMiArNDY0LDkgQEAgaW50IHFj
b21fc2NtX3Bhc19pbml0X2ltYWdlKHUzMiBwZXJpcGhlcmFsLCBjb25zdCB2b2lkICptZXRhZGF0
YSwgc2l6ZV90IHNpemUsCiAJfTsKIAlzdHJ1Y3QgcWNvbV9zY21fcmVzIHJlczsKIAotCS8qCi0J
ICogRHVyaW5nIHRoZSBzY20gY2FsbCBtZW1vcnkgcHJvdGVjdGlvbiB3aWxsIGJlIGVuYWJsZWQg
Zm9yIHRoZSBtZXRhCi0JICogZGF0YSBibG9iLCBzbyBtYWtlIHN1cmUgaXQncyBwaHlzaWNhbGx5
IGNvbnRpZ3VvdXMsIDRLIGFsaWduZWQgYW5kCi0JICogbm9uLWNhY2hhYmxlIHRvIGF2b2lkIFhQ
VSB2aW9sYXRpb25zLgotCSAqLwotCW1kYXRhX2J1ZiA9IGRtYV9hbGxvY19jb2hlcmVudChfX3Nj
bS0+ZGV2LCBzaXplLCAmbWRhdGFfcGh5cywKLQkJCQkgICAgICAgR0ZQX0tFUk5FTCk7Ci0JaWYg
KCFtZGF0YV9idWYpIHsKLQkJZGV2X2VycihfX3NjbS0+ZGV2LCAiQWxsb2NhdGlvbiBvZiBtZXRh
ZGF0YSBidWZmZXIgZmFpbGVkLlxuIik7Ci0JCXJldHVybiAtRU5PTUVNOwotCX0KLQltZW1jcHko
bWRhdGFfYnVmLCBtZXRhZGF0YSwgc2l6ZSk7Ci0KIAlyZXQgPSBxY29tX3NjbV9jbGtfZW5hYmxl
KCk7CiAJaWYgKHJldCkKLQkJZ290byBvdXQ7CisJCXJldHVybiByZXQ7CiAKIAlyZXQgPSBxY29t
X3NjbV9id19lbmFibGUoKTsKIAlpZiAocmV0KQpAQCAtNDk3LDE1ICs0NzksNiBAQCBpbnQgcWNv
bV9zY21fcGFzX2luaXRfaW1hZ2UodTMyIHBlcmlwaGVyYWwsIGNvbnN0IHZvaWQgKm1ldGFkYXRh
LCBzaXplX3Qgc2l6ZSwKIAlxY29tX3NjbV9id19kaXNhYmxlKCk7CiAJcWNvbV9zY21fY2xrX2Rp
c2FibGUoKTsKIAotb3V0OgotCWlmIChyZXQgPCAwIHx8ICFjdHgpIHsKLQkJZG1hX2ZyZWVfY29o
ZXJlbnQoX19zY20tPmRldiwgc2l6ZSwgbWRhdGFfYnVmLCBtZGF0YV9waHlzKTsKLQl9IGVsc2Ug
aWYgKGN0eCkgewotCQljdHgtPnB0ciA9IG1kYXRhX2J1ZjsKLQkJY3R4LT5waHlzID0gbWRhdGFf
cGh5czsKLQkJY3R4LT5zaXplID0gc2l6ZTsKLQl9Ci0KIAlyZXR1cm4gcmV0ID8gOiByZXMucmVz
dWx0WzBdOwogfQogRVhQT1JUX1NZTUJPTChxY29tX3NjbV9wYXNfaW5pdF9pbWFnZSk7CmRpZmYg
LS1naXQgYS9kcml2ZXJzL3NvYy9xY29tL21kdF9sb2FkZXIuYyBiL2RyaXZlcnMvc29jL3Fjb20v
bWR0X2xvYWRlci5jCmluZGV4IDNmMTE1NTQuLjhkMDYxMjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
c29jL3Fjb20vbWR0X2xvYWRlci5jCisrKyBiL2RyaXZlcnMvc29jL3Fjb20vbWR0X2xvYWRlci5j
CkBAIC0yMTAsNiArMjEwLDcgQEAgaW50IHFjb21fbWR0X3Bhc19pbml0KHN0cnVjdCBkZXZpY2Ug
KmRldiwgY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdywKIAljb25zdCBzdHJ1Y3QgZWxmMzJfaGRy
ICplaGRyOwogCXBoeXNfYWRkcl90IG1pbl9hZGRyID0gUEhZU19BRERSX01BWDsKIAlwaHlzX2Fk
ZHJfdCBtYXhfYWRkciA9IDA7CisJZG1hX2FkZHJfdCBtZGF0YV9waHlzOwogCXNpemVfdCBtZXRh
ZGF0YV9sZW47CiAJdm9pZCAqbWV0YWRhdGE7CiAJaW50IHJldDsKQEAgLTIzOCw3ICsyMzksNyBA
QCBpbnQgcWNvbV9tZHRfcGFzX2luaXQoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBzdHJ1Y3Qg
ZmlybXdhcmUgKmZ3LAogCQlnb3RvIG91dDsKIAl9CiAKLQlyZXQgPSBxY29tX3NjbV9wYXNfaW5p
dF9pbWFnZShwYXNfaWQsIG1ldGFkYXRhLCBtZXRhZGF0YV9sZW4sIGN0eCk7CisJcmV0ID0gcWNv
bV9zY21fcGFzX2luaXRfaW1hZ2UocGFzX2lkLCBtZGF0YV9waHlzKTsKIAlrZnJlZShtZXRhZGF0
YSk7CiAJaWYgKHJldCkgewogCQkvKiBJbnZhbGlkIGZpcm13YXJlIG1ldGFkYXRhICovCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3Fjb21fc2NtLmggYi9pbmNsdWRlL2xpbnV4L3Fjb21fc2Nt
LmgKaW5kZXggZjgzMzU2NC4uNzUxNDM2YSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9xY29t
X3NjbS5oCisrKyBiL2luY2x1ZGUvbGludXgvcWNvbV9zY20uaApAQCAtNzQsOSArNzQsNyBAQCBz
dHJ1Y3QgcWNvbV9zY21fcGFzX21ldGFkYXRhIHsKIAlzc2l6ZV90IHNpemU7CiB9OwogCi1leHRl
cm4gaW50IHFjb21fc2NtX3Bhc19pbml0X2ltYWdlKHUzMiBwZXJpcGhlcmFsLCBjb25zdCB2b2lk
ICptZXRhZGF0YSwKLQkJCQkgICBzaXplX3Qgc2l6ZSwKLQkJCQkgICBzdHJ1Y3QgcWNvbV9zY21f
cGFzX21ldGFkYXRhICpjdHgpOworZXh0ZXJuIGludCBxY29tX3NjbV9wYXNfaW5pdF9pbWFnZSh1
MzIgcGVyaXBoZXJhbCwgZG1hX2FkZHJfdCBtZXRhZGF0YSk7CiB2b2lkIHFjb21fc2NtX3Bhc19t
ZXRhZGF0YV9yZWxlYXNlKHN0cnVjdCBxY29tX3NjbV9wYXNfbWV0YWRhdGEgKmN0eCk7CiBleHRl
cm4gaW50IHFjb21fc2NtX3Bhc19tZW1fc2V0dXAodTMyIHBlcmlwaGVyYWwsIHBoeXNfYWRkcl90
IGFkZHIsCiAJCQkJICBwaHlzX2FkZHJfdCBzaXplKTsKLS0gCjIuNy40Cgo=

--_003_40718b43db8f4702b0dbfec79b6fc8abquicinccom_
Content-Type: application/octet-stream;
	name="v2-0002-soc-qcom-mdt_loader-Move-the-memory-allocation-in.patch"
Content-Description: v2-0002-soc-qcom-mdt_loader-Move-the-memory-allocation-in.patch
Content-Disposition: attachment;
	filename="v2-0002-soc-qcom-mdt_loader-Move-the-memory-allocation-in.patch";
	size=9147; creation-date="Wed, 21 Sep 2022 16:27:42 GMT";
	modification-date="Wed, 21 Sep 2022 16:27:42 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4N2ZiMjFhMzM3MTMwNzliZGVkZjUxMDJmNGYxNTZlZGRiNTc3MGU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8ODdmYjIxYTMzNzEzMDc5YmRlZGY1MTAyZjRmMTU2
ZWRkYjU3NzBlNS4xNjYzNzc3NjYyLmdpdC5xdWljX2dva3VrcmlzQHF1aWNpbmMuY29tPgpJbi1S
ZXBseS1UbzogPGNvdmVyLjE2NjM3Nzc2NjIuZ2l0LnF1aWNfZ29rdWtyaXNAcXVpY2luYy5jb20+
ClJlZmVyZW5jZXM6IDxjb3Zlci4xNjYzNzc3NjYyLmdpdC5xdWljX2dva3VrcmlzQHF1aWNpbmMu
Y29tPgpGcm9tOiBHb2t1bCBrcmlzaG5hIEtyaXNobmFrdW1hciA8cXVpY19nb2t1a3Jpc0BxdWlj
aW5jLmNvbT4KRGF0ZTogTW9uLCAxMiBTZXAgMjAyMiAxMTo0MTozMiAtMDcwMApTdWJqZWN0OiBb
UEFUQ0ggdjIgMi8yXSBzb2M6IHFjb206IG1kdF9sb2FkZXI6IE1vdmUgdGhlIG1lbW9yeSBhbGxv
Y2F0aW9uIGludG8KIG1kdCBsb2FkZXIKCkJ5IG1vdmluZyB0aGUgbWVtb3J5IGFsbG9jYXRpb24g
dG8gbWR0IGxvYWRlciB3ZSBjYW4gc2ltcGxpZnkgdGhlIHNjbQpjYWxsLCBieSBqdXN0IHBhY2tp
bmcgYXJndW1lbnRzIHByb3ZpZGVkIHRvIGl0IGZyb20gdGhlIGNsaWVudHMgZm9yCm1ha2luZyBz
ZWN1ZXIgd29ybGQgY2FsbHMuIFdlIGNhbiBhbHNvIHNpbXBsaWZ5IHRoZSBtZW1vcnkgYWxsb2Nh
dGlvbgpmb3IgdGhlIHFjb20gbWV0YWRhdGEsIGJ5IGp1c3QgZG9pbmcgb25lIG1lbW9yeSBhbGxv
Y2F0aW9uIGluIHRoZQptZHQgbG9hZGVyLgoKU2lnbmVkLW9mZi1ieTogR29rdWwga3Jpc2huYSBL
cmlzaG5ha3VtYXIgPHF1aWNfZ29rdWtyaXNAcXVpY2luYy5jb20+Ci0tLQogZHJpdmVycy9maXJt
d2FyZS9xY29tX3NjbS5jICAgICAgICAgfCAxNiAtLS0tLS0tLS0tCiBkcml2ZXJzL3JlbW90ZXBy
b2MvcWNvbV9xNnY1X21zcy5jICB8ICAyICstCiBkcml2ZXJzL3JlbW90ZXByb2MvcWNvbV9xNnY1
X3Bhcy5jICB8ICA0ICstLQogZHJpdmVycy9zb2MvcWNvbS9tZHRfbG9hZGVyLmMgICAgICAgfCA2
MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tCiBpbmNsdWRlL2xpbnV4L3Fj
b21fc2NtLmggICAgICAgICAgICB8ICAxIC0KIGluY2x1ZGUvbGludXgvc29jL3Fjb20vbWR0X2xv
YWRlci5oIHwgMTMgKysrKysrLS0KIDYgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKSwg
MzAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9xY29tX3NjbS5j
IGIvZHJpdmVycy9maXJtd2FyZS9xY29tX3NjbS5jCmluZGV4IDA1ZWMwM2MuLmVhMGViYTY1IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3Fjb21fc2NtLmMKKysrIGIvZHJpdmVycy9maXJt
d2FyZS9xY29tX3NjbS5jCkBAIC00ODMsMjIgKzQ4Myw2IEBAIGludCBxY29tX3NjbV9wYXNfaW5p
dF9pbWFnZSh1MzIgcGVyaXBoZXJhbCwgZG1hX2FkZHJfdCBtZGF0YV9waHlzKQogfQogRVhQT1JU
X1NZTUJPTChxY29tX3NjbV9wYXNfaW5pdF9pbWFnZSk7CiAKLS8qKgotICogcWNvbV9zY21fcGFz
X21ldGFkYXRhX3JlbGVhc2UoKSAtIHJlbGVhc2UgbWV0YWRhdGEgY29udGV4dAotICogQGN0eDoJ
bWV0YWRhdGEgY29udGV4dAotICovCi12b2lkIHFjb21fc2NtX3Bhc19tZXRhZGF0YV9yZWxlYXNl
KHN0cnVjdCBxY29tX3NjbV9wYXNfbWV0YWRhdGEgKmN0eCkKLXsKLQlpZiAoIWN0eC0+cHRyKQot
CQlyZXR1cm47Ci0KLQlkbWFfZnJlZV9jb2hlcmVudChfX3NjbS0+ZGV2LCBjdHgtPnNpemUsIGN0
eC0+cHRyLCBjdHgtPnBoeXMpOwotCi0JY3R4LT5wdHIgPSBOVUxMOwotCWN0eC0+cGh5cyA9IDA7
Ci0JY3R4LT5zaXplID0gMDsKLX0KLUVYUE9SVF9TWU1CT0wocWNvbV9zY21fcGFzX21ldGFkYXRh
X3JlbGVhc2UpOwogCiAvKioKICAqIHFjb21fc2NtX3Bhc19tZW1fc2V0dXAoKSAtIFByZXBhcmUg
dGhlIG1lbW9yeSByZWxhdGVkIHRvIGEgZ2l2ZW4gcGVyaXBoZXJhbApkaWZmIC0tZ2l0IGEvZHJp
dmVycy9yZW1vdGVwcm9jL3Fjb21fcTZ2NV9tc3MuYyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9xY29t
X3E2djVfbXNzLmMKaW5kZXggZmRkYjYzYy4uMTkxOWJmYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9y
ZW1vdGVwcm9jL3Fjb21fcTZ2NV9tc3MuYworKysgYi9kcml2ZXJzL3JlbW90ZXByb2MvcWNvbV9x
NnY1X21zcy5jCkBAIC05NDcsNyArOTQ3LDcgQEAgc3RhdGljIGludCBxNnY1X21wc3NfaW5pdF9p
bWFnZShzdHJ1Y3QgcTZ2NSAqcXByb2MsIGNvbnN0IHN0cnVjdCBmaXJtd2FyZSAqZncsCiAJaW50
IHJldDsKIAlpbnQgaTsKIAotCW1ldGFkYXRhID0gcWNvbV9tZHRfcmVhZF9tZXRhZGF0YShmdywg
JnNpemUsIGZ3X25hbWUsIHFwcm9jLT5kZXYpOworCW1ldGFkYXRhID0gcWNvbV9tZHRfcmVhZF9t
ZXRhZGF0YShmdywgJnNpemUsIGZ3X25hbWUsIHFwcm9jLT5kZXYsIE5VTEwpOwogCWlmIChJU19F
UlIobWV0YWRhdGEpKQogCQlyZXR1cm4gUFRSX0VSUihtZXRhZGF0YSk7CiAKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcmVtb3RlcHJvYy9xY29tX3E2djVfcGFzLmMgYi9kcml2ZXJzL3JlbW90ZXByb2Mv
cWNvbV9xNnY1X3Bhcy5jCmluZGV4IDZhZmQwOTQuLmYxMTJmZjQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvcmVtb3RlcHJvYy9xY29tX3E2djVfcGFzLmMKKysrIGIvZHJpdmVycy9yZW1vdGVwcm9jL3Fj
b21fcTZ2NV9wYXMuYwpAQCAtMTU5LDcgKzE1OSw3IEBAIHN0YXRpYyBpbnQgYWRzcF91bnByZXBh
cmUoc3RydWN0IHJwcm9jICpycHJvYykKIAkgKiBhdXRoX2FuZF9yZXNldCgpIHdhcyBzdWNjZXNz
ZnVsLCBidXQgaW4gb3RoZXIgY2FzZXMgY2xlYW4gaXQgdXAKIAkgKiBoZXJlLgogCSAqLwotCXFj
b21fc2NtX3Bhc19tZXRhZGF0YV9yZWxlYXNlKCZhZHNwLT5wYXNfbWV0YWRhdGEpOworCXFjb21f
c2NtX3Bhc19tZXRhZGF0YV9yZWxlYXNlKGFkc3AtPmRldiwgJmFkc3AtPnBhc19tZXRhZGF0YSk7
CiAKIAlyZXR1cm4gMDsKIH0KQEAgLTIzMiw3ICsyMzIsNyBAQCBzdGF0aWMgaW50IGFkc3Bfc3Rh
cnQoc3RydWN0IHJwcm9jICpycHJvYykKIAkJZ290byBkaXNhYmxlX3B4X3N1cHBseTsKIAl9CiAK
LQlxY29tX3NjbV9wYXNfbWV0YWRhdGFfcmVsZWFzZSgmYWRzcC0+cGFzX21ldGFkYXRhKTsKKwlx
Y29tX3NjbV9wYXNfbWV0YWRhdGFfcmVsZWFzZShhZHNwLT5kZXYsICZhZHNwLT5wYXNfbWV0YWRh
dGEpOwogCiAJcmV0dXJuIDA7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL3Fjb20vbWR0X2xv
YWRlci5jIGIvZHJpdmVycy9zb2MvcWNvbS9tZHRfbG9hZGVyLmMKaW5kZXggOGQwNjEyNS4uYWQ4
NzI1ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9zb2MvcWNvbS9tZHRfbG9hZGVyLmMKKysrIGIvZHJp
dmVycy9zb2MvcWNvbS9tZHRfbG9hZGVyLmMKQEAgLTE2LDYgKzE2LDcgQEAKICNpbmNsdWRlIDxs
aW51eC9zaXplcy5oPgogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KICNpbmNsdWRlIDxsaW51eC9z
b2MvcWNvbS9tZHRfbG9hZGVyLmg+CisjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4KIAog
c3RhdGljIGJvb2wgbWR0X3BoZHJfdmFsaWQoY29uc3Qgc3RydWN0IGVsZjMyX3BoZHIgKnBoZHIp
CiB7CkBAIC0xMTAsNiArMTExLDcgQEAgRVhQT1JUX1NZTUJPTF9HUEwocWNvbV9tZHRfZ2V0X3Np
emUpOwogICogQGRhdGFfbGVuOglsZW5ndGggb2YgdGhlIHJlYWQgbWV0YWRhdGEgYmxvYgogICog
QGZ3X25hbWU6CW5hbWUgb2YgdGhlIGZpcm13YXJlLCBmb3IgY29uc3RydWN0aW9uIG9mIHNlZ21l
bnQgZmlsZSBuYW1lcwogICogQGRldjoJZGV2aWNlIGhhbmRsZSB0byBhc3NvY2lhdGUgcmVzb3Vy
Y2VzIHdpdGgKKyAqIEBtZGF0YV9waHlzOglwaHlzIGFkZHJlc3MgZm9yIHRoZSBhc3NpZ25lZCBt
ZXRhZGF0YSBidWZmZXIKICAqCiAgKiBUaGUgbWVjaGFuaXNtIHRoYXQgcGVyZm9ybXMgdGhlIGF1
dGhlbnRpY2F0aW9uIG9mIHRoZSBsb2FkaW5nIGZpcm13YXJlCiAgKiBleHBlY3RzIGFuIEVMRiBo
ZWFkZXIgZGlyZWN0bHkgZm9sbG93ZWQgYnkgdGhlIHNlZ21lbnQgb2YgaGFzaGVzLCB3aXRoIG5v
CkBAIC0xMjQsNyArMTI2LDggQEAgRVhQT1JUX1NZTUJPTF9HUEwocWNvbV9tZHRfZ2V0X3NpemUp
OwogICogUmV0dXJuOiBwb2ludGVyIHRvIGRhdGEsIG9yIEVSUl9QVFIoKQogICovCiB2b2lkICpx
Y29tX21kdF9yZWFkX21ldGFkYXRhKGNvbnN0IHN0cnVjdCBmaXJtd2FyZSAqZncsIHNpemVfdCAq
ZGF0YV9sZW4sCi0JCQkgICAgIGNvbnN0IGNoYXIgKmZ3X25hbWUsIHN0cnVjdCBkZXZpY2UgKmRl
dikKKwkJCSAgICAgY29uc3QgY2hhciAqZndfbmFtZSwgc3RydWN0IGRldmljZSAqZGV2LAorCQkJ
ICAgICBkbWFfYWRkcl90ICptZGF0YV9waHlzKQogewogCWNvbnN0IHN0cnVjdCBlbGYzMl9waGRy
ICpwaGRyczsKIAljb25zdCBzdHJ1Y3QgZWxmMzJfaGRyICplaGRyOwpAQCAtMTYwLDEwICsxNjMs
MjEgQEAgdm9pZCAqcWNvbV9tZHRfcmVhZF9tZXRhZGF0YShjb25zdCBzdHJ1Y3QgZmlybXdhcmUg
KmZ3LCBzaXplX3QgKmRhdGFfbGVuLAogCWVoZHJfc2l6ZSA9IHBoZHJzWzBdLnBfZmlsZXN6Owog
CWhhc2hfc2l6ZSA9IHBoZHJzW2hhc2hfc2VnbWVudF0ucF9maWxlc3o7CiAKLQlkYXRhID0ga21h
bGxvYyhlaGRyX3NpemUgKyBoYXNoX3NpemUsIEdGUF9LRVJORUwpOwotCWlmICghZGF0YSkKKwkv
KgorCSAqIER1cmluZyB0aGUgc2NtIGNhbGwgbWVtb3J5IHByb3RlY3Rpb24gd2lsbCBiZSBlbmFi
bGVkIGZvciB0aGUgbWV0YQorCSAqIGRhdGEgYmxvYiwgc28gbWFrZSBzdXJlIGl0J3MgcGh5c2lj
YWxseSBjb250aWd1b3VzLCA0SyBhbGlnbmVkIGFuZAorCSAqIG5vbi1jYWNoYWJsZSB0byBhdm9p
ZCBYUFUgdmlvbGF0aW9ucy4KKwkgKi8KKwlpZiAobWRhdGFfcGh5cykgeworCQlkYXRhID0gZG1h
X2FsbG9jX2NvaGVyZW50KGRldiwgZWhkcl9zaXplICsgaGFzaF9zaXplLCBtZGF0YV9waHlzLAor
CQkJCSAgICAgICBHRlBfS0VSTkVMKTsKKwl9IGVsc2UgeworCQlkYXRhID0ga21hbGxvYyhlaGRy
X3NpemUgKyBoYXNoX3NpemUsIEdGUF9LRVJORUwpOworCX0KKwlpZiAoIWRhdGEpIHsKKwkJZGV2
X2VycihkZXYsICJBbGxvY2F0aW9uIG9mIG1ldGFkYXRhIGJ1ZmZlciBmYWlsZWQuXG4iKTsKIAkJ
cmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Ci0KKwl9CiAJLyogQ29weSBFTEYgaGVhZGVyICovCiAJ
bWVtY3B5KGRhdGEsIGZ3LT5kYXRhLCBlaGRyX3NpemUpOwogCkBAIC0xNzksNyArMTkzLDExIEBA
IHZvaWQgKnFjb21fbWR0X3JlYWRfbWV0YWRhdGEoY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdywg
c2l6ZV90ICpkYXRhX2xlbiwKIAkJLyogSGFzaCBpcyBpbiBpdHMgb3duIHNlZ21lbnQsIGJleW9u
ZCB0aGUgbG9hZGVkIGZpbGUgKi8KIAkJcmV0ID0gbWR0X2xvYWRfc3BsaXRfc2VnbWVudChkYXRh
ICsgZWhkcl9zaXplLCBwaGRycywgaGFzaF9zZWdtZW50LCBmd19uYW1lLCBkZXYpOwogCQlpZiAo
cmV0KSB7Ci0JCQlrZnJlZShkYXRhKTsKKwkJCWlmIChtZGF0YV9waHlzKSB7CisJCQkJZG1hX2Zy
ZWVfY29oZXJlbnQoZGV2LCBlaGRyX3NpemUgKyBoYXNoX3NpemUsIGRhdGEsICptZGF0YV9waHlz
KTsKKwkJCX0gZWxzZSB7CisJCQkJa2ZyZWUoZGF0YSk7CisJCQl9CiAJCQlyZXR1cm4gRVJSX1BU
UihyZXQpOwogCQl9CiAJfQpAQCAtMTkxLDYgKzIwOSwyMyBAQCB2b2lkICpxY29tX21kdF9yZWFk
X21ldGFkYXRhKGNvbnN0IHN0cnVjdCBmaXJtd2FyZSAqZncsIHNpemVfdCAqZGF0YV9sZW4sCiBF
WFBPUlRfU1lNQk9MX0dQTChxY29tX21kdF9yZWFkX21ldGFkYXRhKTsKIAogLyoqCisgKiBxY29t
X3Bhc19tZXRhZGF0YV9yZWxlYXNlKCkgLSByZWxlYXNlIG1ldGFkYXRhIGNvbnRleHQKKyAqIEBj
dHg6CW1ldGFkYXRhIGNvbnRleHQKKyAqLwordm9pZCBxY29tX3NjbV9wYXNfbWV0YWRhdGFfcmVs
ZWFzZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBxY29tX3NjbV9wYXNfbWV0YWRhdGEgKmN0
eCkKK3sKKwlpZiAoIWN0eC0+cHRyKQorCQlyZXR1cm47CisKKwlkbWFfZnJlZV9jb2hlcmVudChk
ZXYsIGN0eC0+c2l6ZSwgY3R4LT5wdHIsIGN0eC0+cGh5cyk7CisKKwljdHgtPnB0ciA9IE5VTEw7
CisJY3R4LT5waHlzID0gMDsKKwljdHgtPnNpemUgPSAwOworfQorRVhQT1JUX1NZTUJPTChxY29t
X3NjbV9wYXNfbWV0YWRhdGFfcmVsZWFzZSk7CisKKy8qKgogICogcWNvbV9tZHRfcGFzX2luaXQo
KSAtIGluaXRpYWxpemUgUEFTIHJlZ2lvbiBmb3IgZmlybXdhcmUgbG9hZGluZwogICogQGRldjoJ
ZGV2aWNlIGhhbmRsZSB0byBhc3NvY2lhdGUgcmVzb3VyY2VzIHdpdGgKICAqIEBmdzoJCWZpcm13
YXJlIG9iamVjdCBmb3IgdGhlIG1kdCBmaWxlCkBAIC0yMzIsNyArMjY3LDcgQEAgaW50IHFjb21f
bWR0X3Bhc19pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3Qgc3RydWN0IGZpcm13YXJlICpm
dywKIAkJCW1heF9hZGRyID0gQUxJR04ocGhkci0+cF9wYWRkciArIHBoZHItPnBfbWVtc3osIFNa
XzRLKTsKIAl9CiAKLQltZXRhZGF0YSA9IHFjb21fbWR0X3JlYWRfbWV0YWRhdGEoZncsICZtZXRh
ZGF0YV9sZW4sIGZ3X25hbWUsIGRldik7CisJbWV0YWRhdGEgPSBxY29tX21kdF9yZWFkX21ldGFk
YXRhKGZ3LCAmbWV0YWRhdGFfbGVuLCBmd19uYW1lLCBkZXYsICZtZGF0YV9waHlzKTsKIAlpZiAo
SVNfRVJSKG1ldGFkYXRhKSkgewogCQlyZXQgPSBQVFJfRVJSKG1ldGFkYXRhKTsKIAkJZGV2X2Vy
cihkZXYsICJlcnJvciAlZCByZWFkaW5nIGZpcm13YXJlICVzIG1ldGFkYXRhXG4iLCByZXQsIGZ3
X25hbWUpOwpAQCAtMjQwLDcgKzI3NSwxOCBAQCBpbnQgcWNvbV9tZHRfcGFzX2luaXQoc3RydWN0
IGRldmljZSAqZGV2LCBjb25zdCBzdHJ1Y3QgZmlybXdhcmUgKmZ3LAogCX0KIAogCXJldCA9IHFj
b21fc2NtX3Bhc19pbml0X2ltYWdlKHBhc19pZCwgbWRhdGFfcGh5cyk7Ci0Ja2ZyZWUobWV0YWRh
dGEpOworCWlmIChyZXQgfHwgIWN0eCkgeworCQlpZiAobWRhdGFfcGh5cykgeworCQkJZG1hX2Zy
ZWVfY29oZXJlbnQoZGV2LCBtZXRhZGF0YV9sZW4sIG1ldGFkYXRhLCBtZGF0YV9waHlzKTsKKwkJ
fSBlbHNlIHsKKwkJCWtmcmVlKG1ldGFkYXRhKTsKKwkJfQorCX0gZWxzZSBpZiAoY3R4KSB7CisJ
CWN0eC0+cHRyID0gbWV0YWRhdGE7CisJCWN0eC0+cGh5cyA9IG1kYXRhX3BoeXM7CisJCWN0eC0+
c2l6ZSA9IG1ldGFkYXRhX2xlbjsKKwl9CisKIAlpZiAocmV0KSB7CiAJCS8qIEludmFsaWQgZmly
bXdhcmUgbWV0YWRhdGEgKi8KIAkJZGV2X2VycihkZXYsICJlcnJvciAlZCBpbml0aWFsaXppbmcg
ZmlybXdhcmUgJXNcbiIsIHJldCwgZndfbmFtZSk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3Fjb21fc2NtLmggYi9pbmNsdWRlL2xpbnV4L3Fjb21fc2NtLmgKaW5kZXggNzUxNDM2YS4uMDA1
MzkzNiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9xY29tX3NjbS5oCisrKyBiL2luY2x1ZGUv
bGludXgvcWNvbV9zY20uaApAQCAtNzUsNyArNzUsNiBAQCBzdHJ1Y3QgcWNvbV9zY21fcGFzX21l
dGFkYXRhIHsKIH07CiAKIGV4dGVybiBpbnQgcWNvbV9zY21fcGFzX2luaXRfaW1hZ2UodTMyIHBl
cmlwaGVyYWwsIGRtYV9hZGRyX3QgbWV0YWRhdGEpOwotdm9pZCBxY29tX3NjbV9wYXNfbWV0YWRh
dGFfcmVsZWFzZShzdHJ1Y3QgcWNvbV9zY21fcGFzX21ldGFkYXRhICpjdHgpOwogZXh0ZXJuIGlu
dCBxY29tX3NjbV9wYXNfbWVtX3NldHVwKHUzMiBwZXJpcGhlcmFsLCBwaHlzX2FkZHJfdCBhZGRy
LAogCQkJCSAgcGh5c19hZGRyX3Qgc2l6ZSk7CiBleHRlcm4gaW50IHFjb21fc2NtX3Bhc19hdXRo
X2FuZF9yZXNldCh1MzIgcGVyaXBoZXJhbCk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Nv
Yy9xY29tL21kdF9sb2FkZXIuaCBiL2luY2x1ZGUvbGludXgvc29jL3Fjb20vbWR0X2xvYWRlci5o
CmluZGV4IDllOGU2MDQuLjg1NmI2ZjkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc29jL3Fj
b20vbWR0X2xvYWRlci5oCisrKyBiL2luY2x1ZGUvbGludXgvc29jL3Fjb20vbWR0X2xvYWRlci5o
CkBAIC0yOCw4ICsyOCwxMSBAQCBpbnQgcWNvbV9tZHRfbG9hZF9ub19pbml0KHN0cnVjdCBkZXZp
Y2UgKmRldiwgY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdywKIAkJCSAgcGh5c19hZGRyX3QgbWVt
X3BoeXMsIHNpemVfdCBtZW1fc2l6ZSwKIAkJCSAgcGh5c19hZGRyX3QgKnJlbG9jX2Jhc2UpOwog
dm9pZCAqcWNvbV9tZHRfcmVhZF9tZXRhZGF0YShjb25zdCBzdHJ1Y3QgZmlybXdhcmUgKmZ3LCBz
aXplX3QgKmRhdGFfbGVuLAotCQkJICAgICBjb25zdCBjaGFyICpmd19uYW1lLCBzdHJ1Y3QgZGV2
aWNlICpkZXYpOworCQkJICAgICBjb25zdCBjaGFyICpmd19uYW1lLCBzdHJ1Y3QgZGV2aWNlICpk
ZXYsCisJCQkgICAgIGRtYV9hZGRyX3QgKm1kYXRhX3BoeXMpOwogCit2b2lkIHFjb21fc2NtX3Bh
c19tZXRhZGF0YV9yZWxlYXNlKHN0cnVjdCBkZXZpY2UgKmRldiwKKwkJCQkgICBzdHJ1Y3QgcWNv
bV9zY21fcGFzX21ldGFkYXRhICpjdHgpOwogI2Vsc2UgLyogIUlTX0VOQUJMRUQoQ09ORklHX1FD
T01fTURUX0xPQURFUikgKi8KIAogc3RhdGljIGlubGluZSBzc2l6ZV90IHFjb21fbWR0X2dldF9z
aXplKGNvbnN0IHN0cnVjdCBmaXJtd2FyZSAqZncpCkBAIC02NCwxMSArNjcsMTUgQEAgc3RhdGlj
IGlubGluZSBpbnQgcWNvbV9tZHRfbG9hZF9ub19pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwKIAog
c3RhdGljIGlubGluZSB2b2lkICpxY29tX21kdF9yZWFkX21ldGFkYXRhKGNvbnN0IHN0cnVjdCBm
aXJtd2FyZSAqZncsCiAJCQkJCSAgIHNpemVfdCAqZGF0YV9sZW4sIGNvbnN0IGNoYXIgKmZ3X25h
bWUsCi0JCQkJCSAgIHN0cnVjdCBkZXZpY2UgKmRldikKKwkJCQkJICAgc3RydWN0IGRldmljZSAq
ZGV2LCBkbWFfYWRkcl90ICptZGF0YV9waHlzKQogewogCXJldHVybiBFUlJfUFRSKC1FTk9ERVYp
OwogfQotCit2b2lkIHFjb21fc2NtX3Bhc19tZXRhZGF0YV9yZWxlYXNlKHN0cnVjdCBkZXZpY2Ug
KmRldiwKKwkJCQkgICBzdHJ1Y3QgcWNvbV9zY21fcGFzX21ldGFkYXRhICpjdHgpCit7CisJcmV0
dXJuIE5VTEw7Cit9CiAjZW5kaWYgLyogIUlTX0VOQUJMRUQoQ09ORklHX1FDT01fTURUX0xPQURF
UikgKi8KIAogI2VuZGlmCi0tIAoyLjcuNAoK

--_003_40718b43db8f4702b0dbfec79b6fc8abquicinccom_--
