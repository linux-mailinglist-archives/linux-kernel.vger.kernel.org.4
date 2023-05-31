Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8A5717CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjEaKCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjEaKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:02:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DA1E2;
        Wed, 31 May 2023 03:02:08 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V8xxN0012216;
        Wed, 31 May 2023 10:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=lD+2X1zSALQHvTNQsdQg25A3lUc6+zGS5zMnH7ltgxE=;
 b=a7tee/byZ4wOdlA2/DeawESXZtoplRbBxNVRkKkjR6X1rtMfvR1+9CKHD8bGnah9D0+b
 Al6B+Cb/HkhTFcz1H35W/e0iW08o7QoHYeiIf86pkIzYJXBnJeJfiW+GfPSugWpbTFw9
 KntUlJnqSYpIzSBNfV6EdHvdHN/D6gQmUzWPvkEGkbrZ029rx1ShH0OJCRRSvz0OQIly
 qIYNJVBORPaV87KRG3UCf4w/J22S25jme7srk/IoM2fbnCZ8uNlahcsffToROD87j8E5
 6R71mrrPEucF6LL3ZHinODg3GpGPe3Na42IwfIwTGZp2JAnyd9X7RsrO9FXLtUhiJkUO oA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx30f85pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 10:02:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VA1wxi031961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 10:01:58 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 31 May 2023 03:01:53 -0700
Received: from nalasex01b.na.qualcomm.com ([fe80::a057:7d2:b40d:81d6]) by
 nalasex01b.na.qualcomm.com ([fe80::a057:7d2:b40d:81d6%12]) with mapi id
 15.02.0986.042; Wed, 31 May 2023 03:01:53 -0700
From:   "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
To:     Johan Hovold <johan@kernel.org>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>
Subject: RE: [PATCH v7] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth
 SoC QCA2066
Thread-Topic: [PATCH v7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Thread-Index: AQHZk3IcnXyik61A4UCumHqGaYmUyK90mP+A//+MldA=
Date:   Wed, 31 May 2023 10:01:52 +0000
Message-ID: <9ff2d2bd20a34ff6915d605d7591d430@quicinc.com>
References: <20230531034338.23121-1-quic_tjiang@quicinc.com>
 <ZHcYS1PXhhTmrpYa@hovoldconsulting.com>
In-Reply-To: <ZHcYS1PXhhTmrpYa@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.253.74.59]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MwpcjYs_-mi8CKFKkTbCcxyHcAtkATQe
X-Proofpoint-ORIG-GUID: MwpcjYs_-mi8CKFKkTbCcxyHcAtkATQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_06,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1011 adultscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan:
  Thanks for the review, inline comments.

Regards.
Tim


-----Original Message-----
From: Johan Hovold <johan@kernel.org>=20
Sent: Wednesday, May 31, 2023 5:50 PM
To: Tim Jiang (QUIC) <quic_tjiang@quicinc.com>
Cc: marcel@holtmann.org; linux-kernel@vger.kernel.org; linux-bluetooth@vger=
.kernel.org; linux-arm-msm@vger.kernel.org; Balakrishna Godavarthi (QUIC) <=
quic_bgodavar@quicinc.com>; Hemant Gupta (QUIC) <quic_hemantg@quicinc.com>
Subject: Re: [PATCH v7] Bluetooth: hci_qca: Add support for Qualcomm Blueto=
oth SoC QCA2066

On Wed, May 31, 2023 at 11:43:38AM +0800, Tim Jiang wrote:
> This patch adds support for QCA2066 firmware patch and nvm downloading.
> as the RF performance of qca2066 soc chip from different foundries=20
> will be difference, so we use different nvm to configure them by=20
> according to board id.
>=20
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
>  drivers/bluetooth/btqca.c   | 76 ++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btqca.h   |  4 ++
>  drivers/bluetooth/hci_qca.c |  8 +++-
>  3 files changed, 86 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c=20
> index e7e58a956d15..960a409e16d6 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -205,6 +205,48 @@ static int qca_send_reset(struct hci_dev *hdev)
>  	return 0;
>  }
> =20
> +static int qca_read_fw_board_id(struct hci_dev *hdev, u16 *bid) {
> +	u8 cmd;
> +	struct sk_buff *skb;
> +	struct edl_event_hdr *edl;
> +	int err =3D 0;
> +	int bid_len;
> +
> +	bt_dev_dbg(hdev, "QCA read board ID");

Drop this.
[Tim] will address it in v8 version.

> +
> +	cmd =3D EDL_GET_BID_REQ_CMD;
> +	skb =3D __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN=
,
> +				&cmd, 0, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err =3D PTR_ERR(skb);
> +		bt_dev_err(hdev, "Reading QCA board ID failed (%d)", err);
> +		return err;
> +	}
> +
> +	edl =3D skb_pull_data(skb, sizeof(*edl));
> +	if (!edl) {
> +		bt_dev_err(hdev, "QCA read board ID with no header");
> +		err =3D -EILSEQ;
> +		goto out;
> +	}
> +
> +	if (edl->cresp !=3D EDL_CMD_REQ_RES_EVT ||
> +	    edl->rtype !=3D EDL_GET_BID_REQ_CMD) {
> +		bt_dev_err(hdev, "QCA Wrong packet: %d %d", edl->cresp, edl->rtype);
> +		err =3D -EIO;
> +		goto out;
> +	}
> +
> +	bid_len =3D edl->data[0];
> +	*bid =3D (edl->data[1] << 8) + edl->data[2];
> +	bt_dev_info(hdev, "%s: bid len =3D %x, bid =3D %x", __func__, bid_len,=
=20
> +*bid);

This type of information should not be printed by default.

At most this should be dev_dbg() level, but it should probably just be drop=
ped.
[Tim] will address it in v8 version

> +
> +out:
> +	kfree_skb(skb);
> +	return err;
> +}
> +
>  int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)  {
>  	struct sk_buff *skb;
> @@ -574,6 +616,29 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev,=20
> const bdaddr_t *bdaddr)  }  EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
> =20
> +static void qca_generate_nvm_name(struct hci_dev *hdev, char *fwname,
> +		   size_t max_size, struct qca_btsoc_version ver, u16 bid) {
> +	u8 rom_ver =3D 0;

Drop the redundant initialisation.
[Tim] will address it in v8 version.

> +	u32 soc_ver;
> +	const char *variant;
> +
> +	soc_ver =3D get_soc_ver(ver.soc_id, ver.rom_ver);
> +	rom_ver =3D ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
> +
> +	if ((le32_to_cpu(ver.soc_id) & 0x0000ff00) =3D=3D QCA_HSP_GF_SOC_ID)  /=
* hsp gf chip */
> +		variant =3D "g";
> +	else
> +		variant =3D "";
> +
> +	if (bid =3D=3D 0x0)
> +		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
> +	else
> +		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant,=20
> +bid);
> +
> +	bt_dev_info(hdev, "%s: nvm name is %s", __func__, fwname);

dev_dbg(), if at all needed.
[Tim] will address it in v8 version.

> +}
> +
>  int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
>  		   const char *firmware_name)

> @@ -644,7 +716,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baud=
rate,
>  			snprintf(config.fwname, sizeof(config.fwname),
>  				 "qca/crnv%02x.bin", rom_ver);
>  		}
> -	}
> +	} else if (soc_type =3D=3D QCA_QCA2066)
> +		qca_generate_nvm_name(hdev, config.fwname, sizeof(config.fwname),
> +				ver, boardid);

Missing brackets (if one branch has them, all of them should even the curre=
nt code may not be following this).
[Tim] will address it in v8 version.

>  	else if (soc_type =3D=3D QCA_QCA6390)
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/htnv%02x.bin", rom_ver);

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c=20
> index 1b064504b388..bf7683040ebd 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1729,7 +1729,7 @@ static int qca_setup(struct hci_uart *hu)
>  	bt_dev_info(hdev, "setting up %s",
>  		qca_is_wcn399x(soc_type) ? "wcn399x" :
>  		(soc_type =3D=3D QCA_WCN6750) ? "wcn6750" :
> -		(soc_type =3D=3D QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390");
> +		(soc_type =3D=3D QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390/QCA2066");

This just looks very lazy.

How about cleaning up the current implementation if you don't want to make =
this expression worse than it already is?
[Tim] ok, I will introduce "switch case " to make it more clearly

> =20
>  	qca->memdump_state =3D QCA_MEMDUMP_IDLE;
> =20

Johan
