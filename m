Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436F46951DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjBMU1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjBMU1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:27:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA274498;
        Mon, 13 Feb 2023 12:27:38 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9DC146602154;
        Mon, 13 Feb 2023 20:27:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676320057;
        bh=CFVD5TXOOmag3+CDa2S+SpBXRHSSy3g1SXH8CM4J7Z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/yyggZgIFK4T58jA4x8hNaVR+Aeg6fU703I0oUsKBfme4LCZOF14ZsPg4TGXBurm
         rBx2N4vvFdNWc1IEgA/wgJKKh/p85NSVwZZ8rq5ntsxWujjbAq3vP5RE4zxGW69v4q
         HSYOOpRLaA8JUSnigslSGIIOuBcGJwulNxyk1cHaupGmZEqeJh6A50Y/L09PPBuUZ/
         UDXTkQccDM18Mmq12sjbcfzpGgr+TEEF99VrV0L3zADoKZTOh9o8APoJRfF2Ijjr+s
         8j46fh5RDAhXGRDaY95NMZSmTM5laQv2J0Lwao+Lb6wskC75Dmdq/NUUDxTkE6aEDo
         plMuplLAq3R2A==
Received: by mercury (Postfix, from userid 1000)
        id E16BA1060961; Mon, 13 Feb 2023 21:27:34 +0100 (CET)
Date:   Mon, 13 Feb 2023 21:27:34 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5] power: supply: Introduce Qualcomm PMIC GLINK power
 supply
Message-ID: <20230213202734.uetonoessrmelquf@mercury.elektranox.org>
References: <20230207144241.1767973-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vndmwne3325nqbgp"
Content-Disposition: inline
In-Reply-To: <20230207144241.1767973-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vndmwne3325nqbgp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 07, 2023 at 06:42:41AM -0800, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>=20
> The PMIC GLINK service, running on a coprocessor of modern Qualcomm
> platforms, deals with battery charging and fuel gauging, as well as
> reporting status of AC and wireless power supplies.
>=20
> As this is just one of the functionalities provided by the PMIC GLINK
> service, this power supply driver is implemented as an auxilirary bus
> driver, spawned by the main "pmic glink" driver when the PMIC GLINK
> service is detected.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM8350 PDX215
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-MTP & S=
M8450-HDK
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>=20
> Changes since v4:
> - Changed to module_auxiliary_driver()
>=20
> Sebastian, I merged the other patches from v4 for v6.3 in the qcom tree
> and pushed this to:
>   https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
>   qcom-linux/20230201041853.1934355-1-quic_bjorande@quicinc.com
>=20
> I'd be happy to pick this through the Qualcomm tree if you find that
> more convenient.

Please do , if you want to land this in 6.3. My tree does not have
QCOM_PMIC_GLINK, so I cannot even compile test.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>=20
> Thanks,
>=20
>  drivers/power/supply/Kconfig        |    9 +
>  drivers/power/supply/Makefile       |    1 +
>  drivers/power/supply/qcom_battmgr.c | 1411 +++++++++++++++++++++++++++
>  3 files changed, 1421 insertions(+)
>  create mode 100644 drivers/power/supply/qcom_battmgr.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 6a32f022943b..c78be9f322e6 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -174,6 +174,15 @@ config BATTERY_PMU
>  	  Say Y here to expose battery information on Apple machines
>  	  through the generic battery class.
> =20
> +config BATTERY_QCOM_BATTMGR
> +	tristate "Qualcomm PMIC GLINK battery manager support"
> +	depends on QCOM_PMIC_GLINK
> +	select AUXILIARY_BUS
> +	help
> +	  Say Y here to enable the Qualcomm PMIC GLINK power supply driver,
> +	  which is used on modern Qualcomm platforms to provide battery and
> +	  power supply information.
> +
>  config BATTERY_OLPC
>  	tristate "One Laptop Per Child battery"
>  	depends on OLPC_EC
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 3aec9bc10f3c..4adbfba02d05 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_BATTERY_GAUGE_LTC2941)	+=3D ltc2941-batter=
y-gauge.o
>  obj-$(CONFIG_BATTERY_GOLDFISH)	+=3D goldfish_battery.o
>  obj-$(CONFIG_BATTERY_LEGO_EV3)	+=3D lego_ev3_battery.o
>  obj-$(CONFIG_BATTERY_PMU)	+=3D pmu_battery.o
> +obj-$(CONFIG_BATTERY_QCOM_BATTMGR)	+=3D qcom_battmgr.o
>  obj-$(CONFIG_BATTERY_OLPC)	+=3D olpc_battery.o
>  obj-$(CONFIG_BATTERY_SAMSUNG_SDI)	+=3D samsung-sdi-battery.o
>  obj-$(CONFIG_BATTERY_COLLIE)	+=3D collie_battery.o
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/q=
com_battmgr.c
> new file mode 100644
> index 000000000000..ec31f887184f
> --- /dev/null
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -0,0 +1,1411 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Ltd
> + */
> +#include <linux/auxiliary_bus.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/soc/qcom/pdr.h>
> +#include <linux/soc/qcom/pmic_glink.h>
> +#include <linux/math.h>
> +#include <linux/units.h>
> +
> +#define BATTMGR_CHEMISTRY_LEN	4
> +#define BATTMGR_STRING_LEN	128
> +
> +enum qcom_battmgr_variant {
> +	QCOM_BATTMGR_SM8350,
> +	QCOM_BATTMGR_SC8280XP,
> +};
> +
> +#define BATTMGR_BAT_STATUS		0x1
> +
> +#define BATTMGR_REQUEST_NOTIFICATION	0x4
> +
> +#define BATTMGR_NOTIFICATION		0x7
> +#define NOTIF_BAT_PROPERTY		0x30
> +#define NOTIF_USB_PROPERTY		0x32
> +#define NOTIF_WLS_PROPERTY		0x34
> +#define NOTIF_BAT_INFO			0x81
> +#define NOTIF_BAT_STATUS		0x80
> +
> +#define BATTMGR_BAT_INFO		0x9
> +
> +#define BATTMGR_BAT_DISCHARGE_TIME	0xc
> +
> +#define BATTMGR_BAT_CHARGE_TIME		0xd
> +
> +#define BATTMGR_BAT_PROPERTY_GET	0x30
> +#define BATTMGR_BAT_PROPERTY_SET	0x31
> +#define BATT_STATUS			0
> +#define BATT_HEALTH			1
> +#define BATT_PRESENT			2
> +#define BATT_CHG_TYPE			3
> +#define BATT_CAPACITY			4
> +#define BATT_SOH			5
> +#define BATT_VOLT_OCV			6
> +#define BATT_VOLT_NOW			7
> +#define BATT_VOLT_MAX			8
> +#define BATT_CURR_NOW			9
> +#define BATT_CHG_CTRL_LIM		10
> +#define BATT_CHG_CTRL_LIM_MAX		11
> +#define BATT_TEMP			12
> +#define BATT_TECHNOLOGY			13
> +#define BATT_CHG_COUNTER		14
> +#define BATT_CYCLE_COUNT		15
> +#define BATT_CHG_FULL_DESIGN		16
> +#define BATT_CHG_FULL			17
> +#define BATT_MODEL_NAME			18
> +#define BATT_TTF_AVG			19
> +#define BATT_TTE_AVG			20
> +#define BATT_RESISTANCE			21
> +#define BATT_POWER_NOW			22
> +#define BATT_POWER_AVG			23
> +
> +#define BATTMGR_USB_PROPERTY_GET	0x32
> +#define BATTMGR_USB_PROPERTY_SET	0x33
> +#define USB_ONLINE			0
> +#define USB_VOLT_NOW			1
> +#define USB_VOLT_MAX			2
> +#define USB_CURR_NOW			3
> +#define USB_CURR_MAX			4
> +#define USB_INPUT_CURR_LIMIT		5
> +#define USB_TYPE			6
> +#define USB_ADAP_TYPE			7
> +#define USB_MOISTURE_DET_EN		8
> +#define USB_MOISTURE_DET_STS		9
> +
> +#define BATTMGR_WLS_PROPERTY_GET	0x34
> +#define BATTMGR_WLS_PROPERTY_SET	0x35
> +#define WLS_ONLINE			0
> +#define WLS_VOLT_NOW			1
> +#define WLS_VOLT_MAX			2
> +#define WLS_CURR_NOW			3
> +#define WLS_CURR_MAX			4
> +#define WLS_TYPE			5
> +#define WLS_BOOST_EN			6
> +
> +struct qcom_battmgr_enable_request {
> +	struct pmic_glink_hdr hdr;
> +	__le32 battery_id;
> +	__le32 power_state;
> +	__le32 low_capacity;
> +	__le32 high_capacity;
> +};
> +
> +struct qcom_battmgr_property_request {
> +	struct pmic_glink_hdr hdr;
> +	__le32 battery;
> +	__le32 property;
> +	__le32 value;
> +};
> +
> +struct qcom_battmgr_update_request {
> +	struct pmic_glink_hdr hdr;
> +	u32 battery_id;
> +};
> +
> +struct qcom_battmgr_charge_time_request {
> +	struct pmic_glink_hdr hdr;
> +	__le32 battery_id;
> +	__le32 percent;
> +	__le32 reserved;
> +};
> +
> +struct qcom_battmgr_discharge_time_request {
> +	struct pmic_glink_hdr hdr;
> +	__le32 battery_id;
> +	__le32 rate; /* 0 for current rate */
> +	__le32 reserved;
> +};
> +
> +struct qcom_battmgr_message {
> +	struct pmic_glink_hdr hdr;
> +	union {
> +		struct {
> +			__le32 property;
> +			__le32 value;
> +			__le32 result;
> +		} intval;
> +		struct {
> +			__le32 property;
> +			char model[BATTMGR_STRING_LEN];
> +		} strval;
> +		struct {
> +			/*
> +			 * 0: mWh
> +			 * 1: mAh
> +			 */
> +			__le32 power_unit;
> +			__le32 design_capacity;
> +			__le32 last_full_capacity;
> +			/*
> +			 * 0 nonrechargable
> +			 * 1 rechargable
> +			 */
> +			__le32 battery_tech;
> +			__le32 design_voltage; /* mV */
> +			__le32 capacity_low;
> +			__le32 capacity_warning;
> +			__le32 cycle_count;
> +			/* thousandth of persent */
> +			__le32 accuracy;
> +			__le32 max_sample_time_ms;
> +			__le32 min_sample_time_ms;
> +			__le32 max_average_interval_ms;
> +			__le32 min_average_interval_ms;
> +			/* granularity between low and warning */
> +			__le32 capacity_granularity1;
> +			/* granularity between warning and full */
> +			__le32 capacity_granularity2;
> +			/*
> +			 * 0: no
> +			 * 1: cold
> +			 * 2: hot
> +			 */
> +			__le32 swappable;
> +			__le32 capabilities;
> +			char model_number[BATTMGR_STRING_LEN];
> +			char serial_number[BATTMGR_STRING_LEN];
> +			char battery_type[BATTMGR_STRING_LEN];
> +			char oem_info[BATTMGR_STRING_LEN];
> +			char battery_chemistry[BATTMGR_CHEMISTRY_LEN];
> +			char uid[BATTMGR_STRING_LEN];
> +			__le32 critical_bias;
> +			u8 day;
> +			u8 month;
> +			__le16 year;
> +			__le32 battery_id;
> +		} info;
> +		struct {
> +			/*
> +			 * BIT(0) discharging
> +			 * BIT(1) charging
> +			 * BIT(2) critical low
> +			 */
> +			__le32 battery_state;
> +			/* mWh or mAh, based on info->power_unit */
> +			__le32 capacity;
> +			__le32 rate;
> +			/* mv */
> +			__le32 battery_voltage;
> +			/*
> +			 * BIT(0) power online
> +			 * BIT(1) discharging
> +			 * BIT(2) charging
> +			 * BIT(3) battery critical
> +			 */
> +			__le32 power_state;
> +			/*
> +			 * 1: AC
> +			 * 2: USB
> +			 * 3: Wireless
> +			 */
> +			__le32 charging_source;
> +			__le32 temperature;
> +		} status;
> +		__le32 time;
> +		__le32 notification;
> +	};
> +};
> +
> +#define BATTMGR_CHARGING_SOURCE_AC	1
> +#define BATTMGR_CHARGING_SOURCE_USB	2
> +#define BATTMGR_CHARGING_SOURCE_WIRELESS 3
> +
> +enum qcom_battmgr_unit {
> +	QCOM_BATTMGR_UNIT_mWh =3D 0,
> +	QCOM_BATTMGR_UNIT_mAh =3D 1
> +};
> +
> +struct qcom_battmgr_info {
> +	bool valid;
> +
> +	bool present;
> +	unsigned int charge_type;
> +	unsigned int design_capacity;
> +	unsigned int last_full_capacity;
> +	unsigned int voltage_max_design;
> +	unsigned int voltage_max;
> +	unsigned int capacity_low;
> +	unsigned int capacity_warning;
> +	unsigned int cycle_count;
> +	unsigned int charge_count;
> +	char model_number[BATTMGR_STRING_LEN];
> +	char serial_number[BATTMGR_STRING_LEN];
> +	char oem_info[BATTMGR_STRING_LEN];
> +	unsigned char technology;
> +	unsigned char day;
> +	unsigned char month;
> +	unsigned short year;
> +};
> +
> +struct qcom_battmgr_status {
> +	unsigned int status;
> +	unsigned int health;
> +	unsigned int capacity;
> +	unsigned int percent;
> +	int current_now;
> +	int power_now;
> +	unsigned int voltage_now;
> +	unsigned int voltage_ocv;
> +	unsigned int temperature;
> +
> +	unsigned int discharge_time;
> +	unsigned int charge_time;
> +};
> +
> +struct qcom_battmgr_ac {
> +	bool online;
> +};
> +
> +struct qcom_battmgr_usb {
> +	bool online;
> +	unsigned int voltage_now;
> +	unsigned int voltage_max;
> +	unsigned int current_now;
> +	unsigned int current_max;
> +	unsigned int current_limit;
> +	unsigned int usb_type;
> +};
> +
> +struct qcom_battmgr_wireless {
> +	bool online;
> +	unsigned int voltage_now;
> +	unsigned int voltage_max;
> +	unsigned int current_now;
> +	unsigned int current_max;
> +};
> +
> +struct qcom_battmgr {
> +	struct device *dev;
> +	struct pmic_glink_client *client;
> +
> +	enum qcom_battmgr_variant variant;
> +
> +	struct power_supply *ac_psy;
> +	struct power_supply *bat_psy;
> +	struct power_supply *usb_psy;
> +	struct power_supply *wls_psy;
> +
> +	enum qcom_battmgr_unit unit;
> +
> +	int error;
> +	struct completion ack;
> +
> +	bool service_up;
> +
> +	struct qcom_battmgr_info info;
> +	struct qcom_battmgr_status status;
> +	struct qcom_battmgr_ac ac;
> +	struct qcom_battmgr_usb usb;
> +	struct qcom_battmgr_wireless wireless;
> +
> +	struct work_struct enable_work;
> +
> +	/*
> +	 * @lock is used to prevent concurrent power supply requests to the
> +	 * firmware, as it then stops responding.
> +	 */
> +	struct mutex lock;
> +};
> +
> +static int qcom_battmgr_request(struct qcom_battmgr *battmgr, void *data=
, size_t len)
> +{
> +	unsigned long left;
> +	int ret;
> +
> +	reinit_completion(&battmgr->ack);
> +
> +	battmgr->error =3D 0;
> +
> +	ret =3D pmic_glink_send(battmgr->client, data, len);
> +	if (ret < 0)
> +		return ret;
> +
> +	left =3D wait_for_completion_timeout(&battmgr->ack, HZ);
> +	if (!left)
> +		return -ETIMEDOUT;
> +
> +	return battmgr->error;
> +}
> +
> +static int qcom_battmgr_request_property(struct qcom_battmgr *battmgr, i=
nt opcode,
> +					 int property, u32 value)
> +{
> +	struct qcom_battmgr_property_request request =3D {
> +		.hdr.owner =3D cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
> +		.hdr.type =3D cpu_to_le32(PMIC_GLINK_REQ_RESP),
> +		.hdr.opcode =3D cpu_to_le32(opcode),
> +		.battery =3D cpu_to_le32(0),
> +		.property =3D cpu_to_le32(property),
> +		.value =3D cpu_to_le32(value),
> +	};
> +
> +	return qcom_battmgr_request(battmgr, &request, sizeof(request));
> +}
> +
> +static int qcom_battmgr_update_status(struct qcom_battmgr *battmgr)
> +{
> +	struct qcom_battmgr_update_request request =3D {
> +		.hdr.owner =3D cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
> +		.hdr.type =3D cpu_to_le32(PMIC_GLINK_REQ_RESP),
> +		.hdr.opcode =3D cpu_to_le32(BATTMGR_BAT_STATUS),
> +		.battery_id =3D cpu_to_le32(0),
> +	};
> +
> +	return qcom_battmgr_request(battmgr, &request, sizeof(request));
> +}
> +
> +static int qcom_battmgr_update_info(struct qcom_battmgr *battmgr)
> +{
> +	struct qcom_battmgr_update_request request =3D {
> +		.hdr.owner =3D cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
> +		.hdr.type =3D cpu_to_le32(PMIC_GLINK_REQ_RESP),
> +		.hdr.opcode =3D cpu_to_le32(BATTMGR_BAT_INFO),
> +		.battery_id =3D cpu_to_le32(0),
> +	};
> +
> +	return qcom_battmgr_request(battmgr, &request, sizeof(request));
> +}
> +
> +static int qcom_battmgr_update_charge_time(struct qcom_battmgr *battmgr)
> +{
> +	struct qcom_battmgr_charge_time_request request =3D {
> +		.hdr.owner =3D cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
> +		.hdr.type =3D cpu_to_le32(PMIC_GLINK_REQ_RESP),
> +		.hdr.opcode =3D cpu_to_le32(BATTMGR_BAT_CHARGE_TIME),
> +		.battery_id =3D cpu_to_le32(0),
> +		.percent =3D cpu_to_le32(100),
> +	};
> +
> +	return qcom_battmgr_request(battmgr, &request, sizeof(request));
> +}
> +
> +static int qcom_battmgr_update_discharge_time(struct qcom_battmgr *battm=
gr)
> +{
> +	struct qcom_battmgr_discharge_time_request request =3D {
> +		.hdr.owner =3D cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
> +		.hdr.type =3D cpu_to_le32(PMIC_GLINK_REQ_RESP),
> +		.hdr.opcode =3D cpu_to_le32(BATTMGR_BAT_DISCHARGE_TIME),
> +		.battery_id =3D cpu_to_le32(0),
> +		.rate =3D cpu_to_le32(0),
> +	};
> +
> +	return qcom_battmgr_request(battmgr, &request, sizeof(request));
> +}
> +
> +static const u8 sm8350_bat_prop_map[] =3D {
> +	[POWER_SUPPLY_PROP_STATUS] =3D BATT_STATUS,
> +	[POWER_SUPPLY_PROP_HEALTH] =3D BATT_HEALTH,
> +	[POWER_SUPPLY_PROP_PRESENT] =3D BATT_PRESENT,
> +	[POWER_SUPPLY_PROP_CHARGE_TYPE] =3D BATT_CHG_TYPE,
> +	[POWER_SUPPLY_PROP_CAPACITY] =3D BATT_CAPACITY,
> +	[POWER_SUPPLY_PROP_VOLTAGE_OCV] =3D BATT_VOLT_OCV,
> +	[POWER_SUPPLY_PROP_VOLTAGE_NOW] =3D BATT_VOLT_NOW,
> +	[POWER_SUPPLY_PROP_VOLTAGE_MAX] =3D BATT_VOLT_MAX,
> +	[POWER_SUPPLY_PROP_CURRENT_NOW] =3D BATT_CURR_NOW,
> +	[POWER_SUPPLY_PROP_TEMP] =3D BATT_TEMP,
> +	[POWER_SUPPLY_PROP_TECHNOLOGY] =3D BATT_TECHNOLOGY,
> +	[POWER_SUPPLY_PROP_CHARGE_COUNTER] =3D  BATT_CHG_COUNTER,
> +	[POWER_SUPPLY_PROP_CYCLE_COUNT] =3D BATT_CYCLE_COUNT,
> +	[POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN] =3D  BATT_CHG_FULL_DESIGN,
> +	[POWER_SUPPLY_PROP_CHARGE_FULL] =3D BATT_CHG_FULL,
> +	[POWER_SUPPLY_PROP_MODEL_NAME] =3D BATT_MODEL_NAME,
> +	[POWER_SUPPLY_PROP_TIME_TO_FULL_AVG] =3D BATT_TTF_AVG,
> +	[POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG] =3D BATT_TTE_AVG,
> +	[POWER_SUPPLY_PROP_POWER_NOW] =3D BATT_POWER_NOW,
> +};
> +
> +static int qcom_battmgr_bat_sm8350_update(struct qcom_battmgr *battmgr,
> +					  enum power_supply_property psp)
> +{
> +	unsigned int prop;
> +	int ret;
> +
> +	if (psp >=3D ARRAY_SIZE(sm8350_bat_prop_map))
> +		return -EINVAL;
> +
> +	prop =3D sm8350_bat_prop_map[psp];
> +
> +	mutex_lock(&battmgr->lock);
> +	ret =3D qcom_battmgr_request_property(battmgr, BATTMGR_BAT_PROPERTY_GET=
, prop, 0);
> +	mutex_unlock(&battmgr->lock);
> +
> +	return ret;
> +}
> +
> +static int qcom_battmgr_bat_sc8280xp_update(struct qcom_battmgr *battmgr,
> +					    enum power_supply_property psp)
> +{
> +	int ret;
> +
> +	mutex_lock(&battmgr->lock);
> +
> +	if (!battmgr->info.valid) {
> +		ret =3D qcom_battmgr_update_info(battmgr);
> +		if (ret < 0)
> +			goto out_unlock;
> +		battmgr->info.valid =3D true;
> +	}
> +
> +	ret =3D qcom_battmgr_update_status(battmgr);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	if (psp =3D=3D POWER_SUPPLY_PROP_TIME_TO_FULL_AVG) {
> +		ret =3D qcom_battmgr_update_charge_time(battmgr);
> +		if (ret < 0) {
> +			ret =3D -ENODATA;
> +			goto out_unlock;
> +		}
> +	}
> +
> +	if (psp =3D=3D POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG) {
> +		ret =3D qcom_battmgr_update_discharge_time(battmgr);
> +		if (ret < 0) {
> +			ret =3D -ENODATA;
> +			goto out_unlock;
> +		}
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&battmgr->lock);
> +	return ret;
> +}
> +
> +static int qcom_battmgr_bat_get_property(struct power_supply *psy,
> +					 enum power_supply_property psp,
> +					 union power_supply_propval *val)
> +{
> +	struct qcom_battmgr *battmgr =3D power_supply_get_drvdata(psy);
> +	enum qcom_battmgr_unit unit =3D battmgr->unit;
> +	int ret;
> +
> +	if (!battmgr->service_up)
> +		return -ENODEV;
> +
> +	if (battmgr->variant =3D=3D QCOM_BATTMGR_SC8280XP)
> +		ret =3D qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
> +	else
> +		ret =3D qcom_battmgr_bat_sm8350_update(battmgr, psp);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D battmgr->status.status;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		val->intval =3D battmgr->info.charge_type;
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		val->intval =3D battmgr->status.health;
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D battmgr->info.present;
> +		break;
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval =3D battmgr->info.technology;
> +		break;
> +	case POWER_SUPPLY_PROP_CYCLE_COUNT:
> +		val->intval =3D battmgr->info.cycle_count;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		val->intval =3D battmgr->info.voltage_max_design;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		val->intval =3D battmgr->info.voltage_max;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval =3D battmgr->status.voltage_now;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
> +		val->intval =3D battmgr->status.voltage_ocv;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		val->intval =3D battmgr->status.current_now;
> +		break;
> +	case POWER_SUPPLY_PROP_POWER_NOW:
> +		val->intval =3D battmgr->status.power_now;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		if (unit !=3D QCOM_BATTMGR_UNIT_mAh)
> +			return -ENODATA;
> +		val->intval =3D battmgr->info.design_capacity;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		if (unit !=3D QCOM_BATTMGR_UNIT_mAh)
> +			return -ENODATA;
> +		val->intval =3D battmgr->info.last_full_capacity;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_EMPTY:
> +		if (unit !=3D QCOM_BATTMGR_UNIT_mAh)
> +			return -ENODATA;
> +		val->intval =3D battmgr->info.capacity_low;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		if (unit !=3D QCOM_BATTMGR_UNIT_mAh)
> +			return -ENODATA;
> +		val->intval =3D battmgr->status.capacity;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
> +		val->intval =3D battmgr->info.charge_count;
> +		break;
> +	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> +		if (unit !=3D QCOM_BATTMGR_UNIT_mWh)
> +			return -ENODATA;
> +		val->intval =3D battmgr->info.design_capacity;
> +		break;
> +	case POWER_SUPPLY_PROP_ENERGY_FULL:
> +		if (unit !=3D QCOM_BATTMGR_UNIT_mWh)
> +			return -ENODATA;
> +		val->intval =3D battmgr->info.last_full_capacity;
> +		break;
> +	case POWER_SUPPLY_PROP_ENERGY_EMPTY:
> +		if (unit !=3D QCOM_BATTMGR_UNIT_mWh)
> +			return -ENODATA;
> +		val->intval =3D battmgr->info.capacity_low;
> +		break;
> +	case POWER_SUPPLY_PROP_ENERGY_NOW:
> +		if (unit !=3D QCOM_BATTMGR_UNIT_mWh)
> +			return -ENODATA;
> +		val->intval =3D battmgr->status.capacity;
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		val->intval =3D battmgr->status.percent;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		val->intval =3D battmgr->status.temperature;
> +		break;
> +	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
> +		val->intval =3D battmgr->status.discharge_time;
> +		break;
> +	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
> +		val->intval =3D battmgr->status.charge_time;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
> +		val->intval =3D battmgr->info.year;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURE_MONTH:
> +		val->intval =3D battmgr->info.month;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURE_DAY:
> +		val->intval =3D battmgr->info.day;
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D battmgr->info.model_number;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D battmgr->info.oem_info;
> +		break;
> +	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
> +		val->strval =3D battmgr->info.serial_number;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const enum power_supply_property sc8280xp_bat_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_POWER_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_EMPTY,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_ENERGY_FULL,
> +	POWER_SUPPLY_PROP_ENERGY_EMPTY,
> +	POWER_SUPPLY_PROP_ENERGY_NOW,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
> +	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
> +	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +};
> +
> +static const struct power_supply_desc sc8280xp_bat_psy_desc =3D {
> +	.name =3D "qcom-battmgr-bat",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D sc8280xp_bat_props,
> +	.num_properties =3D ARRAY_SIZE(sc8280xp_bat_props),
> +	.get_property =3D qcom_battmgr_bat_get_property,
> +};
> +
> +static const enum power_supply_property sm8350_bat_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_VOLTAGE_OCV,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CHARGE_COUNTER,
> +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
> +	POWER_SUPPLY_PROP_POWER_NOW,
> +};
> +
> +static const struct power_supply_desc sm8350_bat_psy_desc =3D {
> +	.name =3D "qcom-battmgr-bat",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D sm8350_bat_props,
> +	.num_properties =3D ARRAY_SIZE(sm8350_bat_props),
> +	.get_property =3D qcom_battmgr_bat_get_property,
> +};
> +
> +static int qcom_battmgr_ac_get_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					union power_supply_propval *val)
> +{
> +	struct qcom_battmgr *battmgr =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	if (!battmgr->service_up)
> +		return -ENODEV;
> +
> +	ret =3D qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
> +	if (ret)
> +		return ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D battmgr->ac.online;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const enum power_supply_property sc8280xp_ac_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +};
> +
> +static const struct power_supply_desc sc8280xp_ac_psy_desc =3D {
> +	.name =3D "qcom-battmgr-ac",
> +	.type =3D POWER_SUPPLY_TYPE_MAINS,
> +	.properties =3D sc8280xp_ac_props,
> +	.num_properties =3D ARRAY_SIZE(sc8280xp_ac_props),
> +	.get_property =3D qcom_battmgr_ac_get_property,
> +};
> +
> +static const u8 sm8350_usb_prop_map[] =3D {
> +	[POWER_SUPPLY_PROP_ONLINE] =3D USB_ONLINE,
> +	[POWER_SUPPLY_PROP_VOLTAGE_NOW] =3D USB_VOLT_NOW,
> +	[POWER_SUPPLY_PROP_VOLTAGE_MAX] =3D USB_VOLT_MAX,
> +	[POWER_SUPPLY_PROP_CURRENT_NOW] =3D USB_CURR_NOW,
> +	[POWER_SUPPLY_PROP_CURRENT_MAX] =3D USB_CURR_MAX,
> +	[POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT] =3D USB_INPUT_CURR_LIMIT,
> +	[POWER_SUPPLY_PROP_USB_TYPE] =3D USB_TYPE,
> +};
> +
> +static int qcom_battmgr_usb_sm8350_update(struct qcom_battmgr *battmgr,
> +					  enum power_supply_property psp)
> +{
> +	unsigned int prop;
> +	int ret;
> +
> +	if (psp >=3D ARRAY_SIZE(sm8350_usb_prop_map))
> +		return -EINVAL;
> +
> +	prop =3D sm8350_usb_prop_map[psp];
> +
> +	mutex_lock(&battmgr->lock);
> +	ret =3D qcom_battmgr_request_property(battmgr, BATTMGR_USB_PROPERTY_GET=
, prop, 0);
> +	mutex_unlock(&battmgr->lock);
> +
> +	return ret;
> +}
> +
> +static int qcom_battmgr_usb_get_property(struct power_supply *psy,
> +					 enum power_supply_property psp,
> +					 union power_supply_propval *val)
> +{
> +	struct qcom_battmgr *battmgr =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	if (!battmgr->service_up)
> +		return -ENODEV;
> +
> +	if (battmgr->variant =3D=3D QCOM_BATTMGR_SC8280XP)
> +		ret =3D qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
> +	else
> +		ret =3D qcom_battmgr_usb_sm8350_update(battmgr, psp);
> +	if (ret)
> +		return ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D battmgr->usb.online;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval =3D battmgr->usb.voltage_now;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		val->intval =3D battmgr->usb.voltage_max;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		val->intval =3D battmgr->usb.current_now;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		val->intval =3D battmgr->usb.current_max;
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		val->intval =3D battmgr->usb.current_limit;
> +		break;
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		val->intval =3D battmgr->usb.usb_type;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const enum power_supply_usb_type usb_psy_supported_types[] =3D {
> +	POWER_SUPPLY_USB_TYPE_UNKNOWN,
> +	POWER_SUPPLY_USB_TYPE_SDP,
> +	POWER_SUPPLY_USB_TYPE_DCP,
> +	POWER_SUPPLY_USB_TYPE_CDP,
> +	POWER_SUPPLY_USB_TYPE_ACA,
> +	POWER_SUPPLY_USB_TYPE_C,
> +	POWER_SUPPLY_USB_TYPE_PD,
> +	POWER_SUPPLY_USB_TYPE_PD_DRP,
> +	POWER_SUPPLY_USB_TYPE_PD_PPS,
> +	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,
> +};
> +
> +static const enum power_supply_property sc8280xp_usb_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +};
> +
> +static const struct power_supply_desc sc8280xp_usb_psy_desc =3D {
> +	.name =3D "qcom-battmgr-usb",
> +	.type =3D POWER_SUPPLY_TYPE_USB,
> +	.properties =3D sc8280xp_usb_props,
> +	.num_properties =3D ARRAY_SIZE(sc8280xp_usb_props),
> +	.get_property =3D qcom_battmgr_usb_get_property,
> +	.usb_types =3D usb_psy_supported_types,
> +	.num_usb_types =3D ARRAY_SIZE(usb_psy_supported_types),
> +};
> +
> +static const enum power_supply_property sm8350_usb_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +};
> +
> +static const struct power_supply_desc sm8350_usb_psy_desc =3D {
> +	.name =3D "qcom-battmgr-usb",
> +	.type =3D POWER_SUPPLY_TYPE_USB,
> +	.properties =3D sm8350_usb_props,
> +	.num_properties =3D ARRAY_SIZE(sm8350_usb_props),
> +	.get_property =3D qcom_battmgr_usb_get_property,
> +	.usb_types =3D usb_psy_supported_types,
> +	.num_usb_types =3D ARRAY_SIZE(usb_psy_supported_types),
> +};
> +
> +static const u8 sm8350_wls_prop_map[] =3D {
> +	[POWER_SUPPLY_PROP_ONLINE] =3D WLS_ONLINE,
> +	[POWER_SUPPLY_PROP_VOLTAGE_NOW] =3D WLS_VOLT_NOW,
> +	[POWER_SUPPLY_PROP_VOLTAGE_MAX] =3D WLS_VOLT_MAX,
> +	[POWER_SUPPLY_PROP_CURRENT_NOW] =3D WLS_CURR_NOW,
> +	[POWER_SUPPLY_PROP_CURRENT_MAX] =3D WLS_CURR_MAX,
> +};
> +
> +static int qcom_battmgr_wls_sm8350_update(struct qcom_battmgr *battmgr,
> +					  enum power_supply_property psp)
> +{
> +	unsigned int prop;
> +	int ret;
> +
> +	if (psp >=3D ARRAY_SIZE(sm8350_wls_prop_map))
> +		return -EINVAL;
> +
> +	prop =3D sm8350_wls_prop_map[psp];
> +
> +	mutex_lock(&battmgr->lock);
> +	ret =3D qcom_battmgr_request_property(battmgr, BATTMGR_WLS_PROPERTY_GET=
, prop, 0);
> +	mutex_unlock(&battmgr->lock);
> +
> +	return ret;
> +}
> +
> +static int qcom_battmgr_wls_get_property(struct power_supply *psy,
> +					 enum power_supply_property psp,
> +					 union power_supply_propval *val)
> +{
> +	struct qcom_battmgr *battmgr =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	if (!battmgr->service_up)
> +		return -ENODEV;
> +
> +	if (battmgr->variant =3D=3D QCOM_BATTMGR_SC8280XP)
> +		ret =3D qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
> +	else
> +		ret =3D qcom_battmgr_wls_sm8350_update(battmgr, psp);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D battmgr->wireless.online;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval =3D battmgr->wireless.voltage_now;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		val->intval =3D battmgr->wireless.voltage_max;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		val->intval =3D battmgr->wireless.current_now;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		val->intval =3D battmgr->wireless.current_max;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const enum power_supply_property sc8280xp_wls_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +};
> +
> +static const struct power_supply_desc sc8280xp_wls_psy_desc =3D {
> +	.name =3D "qcom-battmgr-wls",
> +	.type =3D POWER_SUPPLY_TYPE_WIRELESS,
> +	.properties =3D sc8280xp_wls_props,
> +	.num_properties =3D ARRAY_SIZE(sc8280xp_wls_props),
> +	.get_property =3D qcom_battmgr_wls_get_property,
> +};
> +
> +static const enum power_supply_property sm8350_wls_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +};
> +
> +static const struct power_supply_desc sm8350_wls_psy_desc =3D {
> +	.name =3D "qcom-battmgr-wls",
> +	.type =3D POWER_SUPPLY_TYPE_WIRELESS,
> +	.properties =3D sm8350_wls_props,
> +	.num_properties =3D ARRAY_SIZE(sm8350_wls_props),
> +	.get_property =3D qcom_battmgr_wls_get_property,
> +};
> +
> +static void qcom_battmgr_notification(struct qcom_battmgr *battmgr,
> +				      const struct qcom_battmgr_message *msg,
> +				      int len)
> +{
> +	size_t payload_len =3D len - sizeof(struct pmic_glink_hdr);
> +	unsigned int notification;
> +
> +	if (payload_len !=3D sizeof(msg->notification)) {
> +		dev_warn(battmgr->dev, "ignoring notification with invalid length\n");
> +		return;
> +	}
> +
> +	notification =3D le32_to_cpu(msg->notification);
> +	switch (notification) {
> +	case NOTIF_BAT_INFO:
> +		battmgr->info.valid =3D false;
> +		fallthrough;
> +	case NOTIF_BAT_STATUS:
> +	case NOTIF_BAT_PROPERTY:
> +		power_supply_changed(battmgr->bat_psy);
> +		break;
> +	case NOTIF_USB_PROPERTY:
> +		power_supply_changed(battmgr->usb_psy);
> +		break;
> +	case NOTIF_WLS_PROPERTY:
> +		power_supply_changed(battmgr->wls_psy);
> +		break;
> +	default:
> +		dev_err(battmgr->dev, "unknown notification: %#x\n", notification);
> +		break;
> +	}
> +}
> +
> +static void qcom_battmgr_sc8280xp_strcpy(char *dest, const char *src)
> +{
> +	size_t len =3D src[0];
> +
> +	/* Some firmware versions return Pascal-style strings */
> +	if (len < BATTMGR_STRING_LEN && len =3D=3D strnlen(src + 1, BATTMGR_STR=
ING_LEN - 1)) {
> +		memcpy(dest, src + 1, len);
> +		dest[len] =3D '\0';
> +	} else {
> +		memcpy(dest, src, BATTMGR_STRING_LEN);
> +	}
> +}
> +
> +static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *c=
hemistry)
> +{
> +	if (!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN))
> +		return POWER_SUPPLY_TECHNOLOGY_LION;
> +
> +	pr_err("Unknown battery technology '%s'\n", chemistry);
> +	return POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> +}
> +
> +static unsigned int qcom_battmgr_sc8280xp_convert_temp(unsigned int temp=
erature)
> +{
> +	return DIV_ROUND_CLOSEST(temperature, 10);
> +}
> +
> +static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
> +					   const struct qcom_battmgr_message *resp,
> +					   size_t len)
> +{
> +	unsigned int opcode =3D le32_to_cpu(resp->hdr.opcode);
> +	unsigned int source;
> +	unsigned int state;
> +	size_t payload_len =3D len - sizeof(struct pmic_glink_hdr);
> +
> +	if (payload_len < sizeof(__le32)) {
> +		dev_warn(battmgr->dev, "invalid payload length for %#x: %zd\n",
> +			 opcode, len);
> +		return;
> +	}
> +
> +	switch (opcode) {
> +	case BATTMGR_REQUEST_NOTIFICATION:
> +		battmgr->error =3D 0;
> +		break;
> +	case BATTMGR_BAT_INFO:
> +		if (payload_len !=3D sizeof(resp->info)) {
> +			dev_warn(battmgr->dev,
> +				 "invalid payload length for battery information request: %zd\n",
> +				 payload_len);
> +			battmgr->error =3D -ENODATA;
> +			return;
> +		}
> +
> +		battmgr->unit =3D le32_to_cpu(resp->info.power_unit);
> +
> +		battmgr->info.present =3D true;
> +		battmgr->info.design_capacity =3D le32_to_cpu(resp->info.design_capaci=
ty) * 1000;
> +		battmgr->info.last_full_capacity =3D le32_to_cpu(resp->info.last_full_=
capacity) * 1000;
> +		battmgr->info.voltage_max_design =3D le32_to_cpu(resp->info.design_vol=
tage) * 1000;
> +		battmgr->info.capacity_low =3D le32_to_cpu(resp->info.capacity_low) * =
1000;
> +		battmgr->info.cycle_count =3D le32_to_cpu(resp->info.cycle_count);
> +		qcom_battmgr_sc8280xp_strcpy(battmgr->info.model_number, resp->info.mo=
del_number);
> +		qcom_battmgr_sc8280xp_strcpy(battmgr->info.serial_number, resp->info.s=
erial_number);
> +		battmgr->info.technology =3D qcom_battmgr_sc8280xp_parse_technology(re=
sp->info.battery_chemistry);
> +		qcom_battmgr_sc8280xp_strcpy(battmgr->info.oem_info, resp->info.oem_in=
fo);
> +		battmgr->info.day =3D resp->info.day;
> +		battmgr->info.month =3D resp->info.month;
> +		battmgr->info.year =3D le16_to_cpu(resp->info.year);
> +		break;
> +	case BATTMGR_BAT_STATUS:
> +		if (payload_len !=3D sizeof(resp->status)) {
> +			dev_warn(battmgr->dev,
> +				 "invalid payload length for battery status request: %zd\n",
> +				 payload_len);
> +			battmgr->error =3D -ENODATA;
> +			return;
> +		}
> +
> +		state =3D le32_to_cpu(resp->status.battery_state);
> +		if (state & BIT(0))
> +			battmgr->status.status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		else if (state & BIT(1))
> +			battmgr->status.status =3D POWER_SUPPLY_STATUS_CHARGING;
> +		else
> +			battmgr->status.status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +
> +		battmgr->status.capacity =3D le32_to_cpu(resp->status.capacity) * 1000;
> +		battmgr->status.power_now =3D le32_to_cpu(resp->status.rate) * 1000;
> +		battmgr->status.voltage_now =3D le32_to_cpu(resp->status.battery_volta=
ge) * 1000;
> +		battmgr->status.temperature =3D qcom_battmgr_sc8280xp_convert_temp(le3=
2_to_cpu(resp->status.temperature));
> +
> +		source =3D le32_to_cpu(resp->status.charging_source);
> +		battmgr->ac.online =3D source =3D=3D BATTMGR_CHARGING_SOURCE_AC;
> +		battmgr->usb.online =3D source =3D=3D BATTMGR_CHARGING_SOURCE_USB;
> +		battmgr->wireless.online =3D source =3D=3D BATTMGR_CHARGING_SOURCE_WIR=
ELESS;
> +		break;
> +	case BATTMGR_BAT_DISCHARGE_TIME:
> +		battmgr->status.discharge_time =3D le32_to_cpu(resp->time);
> +		break;
> +	case BATTMGR_BAT_CHARGE_TIME:
> +		battmgr->status.charge_time =3D le32_to_cpu(resp->time);
> +		break;
> +	default:
> +		dev_warn(battmgr->dev, "unknown message %#x\n", opcode);
> +		break;
> +	}
> +
> +	complete(&battmgr->ack);
> +}
> +
> +static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
> +					 const struct qcom_battmgr_message *resp,
> +					 size_t len)
> +{
> +	unsigned int property;
> +	unsigned int opcode =3D le32_to_cpu(resp->hdr.opcode);
> +	size_t payload_len =3D len - sizeof(struct pmic_glink_hdr);
> +	unsigned int val;
> +
> +	if (payload_len < sizeof(__le32)) {
> +		dev_warn(battmgr->dev, "invalid payload length for %#x: %zd\n",
> +			 opcode, len);
> +		return;
> +	}
> +
> +	switch (opcode) {
> +	case BATTMGR_BAT_PROPERTY_GET:
> +		property =3D le32_to_cpu(resp->intval.property);
> +		if (property =3D=3D BATT_MODEL_NAME) {
> +			if (payload_len !=3D sizeof(resp->strval)) {
> +				dev_warn(battmgr->dev,
> +					 "invalid payload length for BATT_MODEL_NAME request: %zd\n",
> +					 payload_len);
> +				battmgr->error =3D -ENODATA;
> +				return;
> +			}
> +		} else {
> +			if (payload_len !=3D sizeof(resp->intval)) {
> +				dev_warn(battmgr->dev,
> +					 "invalid payload length for %#x request: %zd\n",
> +					 property, payload_len);
> +				battmgr->error =3D -ENODATA;
> +				return;
> +			}
> +
> +			battmgr->error =3D le32_to_cpu(resp->intval.result);
> +			if (battmgr->error)
> +				goto out_complete;
> +		}
> +
> +		switch (property) {
> +		case BATT_STATUS:
> +			battmgr->status.status =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_HEALTH:
> +			battmgr->status.health =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_PRESENT:
> +			battmgr->info.present =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_CHG_TYPE:
> +			battmgr->info.charge_type =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_CAPACITY:
> +			battmgr->status.percent =3D le32_to_cpu(resp->intval.value);
> +			do_div(battmgr->status.percent, 100);
> +			break;
> +		case BATT_VOLT_OCV:
> +			battmgr->status.voltage_ocv =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_VOLT_NOW:
> +			battmgr->status.voltage_now =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_VOLT_MAX:
> +			battmgr->info.voltage_max =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_CURR_NOW:
> +			battmgr->status.current_now =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_TEMP:
> +			val =3D le32_to_cpu(resp->intval.value);
> +			battmgr->status.temperature =3D DIV_ROUND_CLOSEST(val, 10);
> +			break;
> +		case BATT_TECHNOLOGY:
> +			battmgr->info.technology =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_CHG_COUNTER:
> +			battmgr->info.charge_count =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_CYCLE_COUNT:
> +			battmgr->info.cycle_count =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_CHG_FULL_DESIGN:
> +			battmgr->info.design_capacity =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_CHG_FULL:
> +			battmgr->info.last_full_capacity =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_MODEL_NAME:
> +			strscpy(battmgr->info.model_number, resp->strval.model, BATTMGR_STRIN=
G_LEN);
> +			break;
> +		case BATT_TTF_AVG:
> +			battmgr->status.charge_time =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_TTE_AVG:
> +			battmgr->status.discharge_time =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case BATT_POWER_NOW:
> +			battmgr->status.power_now =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		default:
> +			dev_warn(battmgr->dev, "unknown property %#x\n", property);
> +			break;
> +		}
> +		break;
> +	case BATTMGR_USB_PROPERTY_GET:
> +		property =3D le32_to_cpu(resp->intval.property);
> +		if (payload_len !=3D sizeof(resp->intval)) {
> +			dev_warn(battmgr->dev,
> +				 "invalid payload length for %#x request: %zd\n",
> +				 property, payload_len);
> +			battmgr->error =3D -ENODATA;
> +			return;
> +		}
> +
> +		battmgr->error =3D le32_to_cpu(resp->intval.result);
> +		if (battmgr->error)
> +			goto out_complete;
> +
> +		switch (property) {
> +		case USB_ONLINE:
> +			battmgr->usb.online =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case USB_VOLT_NOW:
> +			battmgr->usb.voltage_now =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case USB_VOLT_MAX:
> +			battmgr->usb.voltage_max =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case USB_CURR_NOW:
> +			battmgr->usb.current_now =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case USB_CURR_MAX:
> +			battmgr->usb.current_max =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case USB_INPUT_CURR_LIMIT:
> +			battmgr->usb.current_limit =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case USB_TYPE:
> +			battmgr->usb.usb_type =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		default:
> +			dev_warn(battmgr->dev, "unknown property %#x\n", property);
> +			break;
> +		}
> +		break;
> +	case BATTMGR_WLS_PROPERTY_GET:
> +		property =3D le32_to_cpu(resp->intval.property);
> +		if (payload_len !=3D sizeof(resp->intval)) {
> +			dev_warn(battmgr->dev,
> +				 "invalid payload length for %#x request: %zd\n",
> +				 property, payload_len);
> +			battmgr->error =3D -ENODATA;
> +			return;
> +		}
> +
> +		battmgr->error =3D le32_to_cpu(resp->intval.result);
> +		if (battmgr->error)
> +			goto out_complete;
> +
> +		switch (property) {
> +		case WLS_ONLINE:
> +			battmgr->wireless.online =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case WLS_VOLT_NOW:
> +			battmgr->wireless.voltage_now =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case WLS_VOLT_MAX:
> +			battmgr->wireless.voltage_max =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case WLS_CURR_NOW:
> +			battmgr->wireless.current_now =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		case WLS_CURR_MAX:
> +			battmgr->wireless.current_max =3D le32_to_cpu(resp->intval.value);
> +			break;
> +		default:
> +			dev_warn(battmgr->dev, "unknown property %#x\n", property);
> +			break;
> +		}
> +		break;
> +	case BATTMGR_REQUEST_NOTIFICATION:
> +		battmgr->error =3D 0;
> +		break;
> +	default:
> +		dev_warn(battmgr->dev, "unknown message %#x\n", opcode);
> +		break;
> +	}
> +
> +out_complete:
> +	complete(&battmgr->ack);
> +}
> +
> +static void qcom_battmgr_callback(const void *data, size_t len, void *pr=
iv)
> +{
> +	const struct pmic_glink_hdr *hdr =3D data;
> +	struct qcom_battmgr *battmgr =3D priv;
> +	unsigned int opcode =3D le32_to_cpu(hdr->opcode);
> +
> +	if (opcode =3D=3D BATTMGR_NOTIFICATION)
> +		qcom_battmgr_notification(battmgr, data, len);
> +	else if (battmgr->variant =3D=3D QCOM_BATTMGR_SC8280XP)
> +		qcom_battmgr_sc8280xp_callback(battmgr, data, len);
> +	else
> +		qcom_battmgr_sm8350_callback(battmgr, data, len);
> +}
> +
> +static void qcom_battmgr_enable_worker(struct work_struct *work)
> +{
> +	struct qcom_battmgr *battmgr =3D container_of(work, struct qcom_battmgr=
, enable_work);
> +	struct qcom_battmgr_enable_request req =3D {
> +		.hdr.owner =3D PMIC_GLINK_OWNER_BATTMGR,
> +		.hdr.type =3D PMIC_GLINK_NOTIFY,
> +		.hdr.opcode =3D BATTMGR_REQUEST_NOTIFICATION,
> +	};
> +	int ret;
> +
> +	ret =3D qcom_battmgr_request(battmgr, &req, sizeof(req));
> +	if (ret)
> +		dev_err(battmgr->dev, "failed to request power notifications\n");
> +}
> +
> +static void qcom_battmgr_pdr_notify(void *priv, int state)
> +{
> +	struct qcom_battmgr *battmgr =3D priv;
> +
> +	if (state =3D=3D SERVREG_SERVICE_STATE_UP) {
> +		battmgr->service_up =3D true;
> +		schedule_work(&battmgr->enable_work);
> +	} else {
> +		battmgr->service_up =3D false;
> +	}
> +}
> +
> +static const struct of_device_id qcom_battmgr_of_variants[] =3D {
> +	{ .compatible =3D "qcom,sc8180x-pmic-glink", .data =3D (void *)QCOM_BAT=
TMGR_SC8280XP },
> +	{ .compatible =3D "qcom,sc8280xp-pmic-glink", .data =3D (void *)QCOM_BA=
TTMGR_SC8280XP },
> +	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
> +	{}
> +};
> +
> +static char *qcom_battmgr_battery[] =3D { "battery" };
> +
> +static int qcom_battmgr_probe(struct auxiliary_device *adev,
> +			      const struct auxiliary_device_id *id)
> +{
> +	struct power_supply_config psy_cfg_supply =3D {};
> +	struct power_supply_config psy_cfg =3D {};
> +	const struct of_device_id *match;
> +	struct qcom_battmgr *battmgr;
> +	struct device *dev =3D &adev->dev;
> +
> +	battmgr =3D devm_kzalloc(dev, sizeof(*battmgr), GFP_KERNEL);
> +	if (!battmgr)
> +		return -ENOMEM;
> +
> +	battmgr->dev =3D dev;
> +
> +	psy_cfg.drv_data =3D battmgr;
> +	psy_cfg.of_node =3D adev->dev.of_node;
> +
> +	psy_cfg_supply.drv_data =3D battmgr;
> +	psy_cfg_supply.of_node =3D adev->dev.of_node;
> +	psy_cfg_supply.supplied_to =3D qcom_battmgr_battery;
> +	psy_cfg_supply.num_supplicants =3D 1;
> +
> +	INIT_WORK(&battmgr->enable_work, qcom_battmgr_enable_worker);
> +	mutex_init(&battmgr->lock);
> +	init_completion(&battmgr->ack);
> +
> +	match =3D of_match_device(qcom_battmgr_of_variants, dev->parent);
> +	if (match)
> +		battmgr->variant =3D (unsigned long)match->data;
> +	else
> +		battmgr->variant =3D QCOM_BATTMGR_SM8350;
> +
> +	if (battmgr->variant =3D=3D QCOM_BATTMGR_SC8280XP) {
> +		battmgr->bat_psy =3D devm_power_supply_register(dev, &sc8280xp_bat_psy=
_desc, &psy_cfg);
> +		if (IS_ERR(battmgr->bat_psy))
> +			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
> +					     "failed to register battery power supply\n");
> +
> +		battmgr->ac_psy =3D devm_power_supply_register(dev, &sc8280xp_ac_psy_d=
esc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->ac_psy))
> +			return dev_err_probe(dev, PTR_ERR(battmgr->ac_psy),
> +					     "failed to register AC power supply\n");
> +
> +		battmgr->usb_psy =3D devm_power_supply_register(dev, &sc8280xp_usb_psy=
_desc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->usb_psy))
> +			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
> +					     "failed to register USB power supply\n");
> +
> +		battmgr->wls_psy =3D devm_power_supply_register(dev, &sc8280xp_wls_psy=
_desc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->wls_psy))
> +			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
> +					     "failed to register wireless charing power supply\n");
> +	} else {
> +		battmgr->bat_psy =3D devm_power_supply_register(dev, &sm8350_bat_psy_d=
esc, &psy_cfg);
> +		if (IS_ERR(battmgr->bat_psy))
> +			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
> +					     "failed to register battery power supply\n");
> +
> +		battmgr->usb_psy =3D devm_power_supply_register(dev, &sm8350_usb_psy_d=
esc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->usb_psy))
> +			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
> +					     "failed to register USB power supply\n");
> +
> +		battmgr->wls_psy =3D devm_power_supply_register(dev, &sm8350_wls_psy_d=
esc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->wls_psy))
> +			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
> +					     "failed to register wireless charing power supply\n");
> +	}
> +
> +	battmgr->client =3D devm_pmic_glink_register_client(dev,
> +							  PMIC_GLINK_OWNER_BATTMGR,
> +							  qcom_battmgr_callback,
> +							  qcom_battmgr_pdr_notify,
> +							  battmgr);
> +	return PTR_ERR_OR_ZERO(battmgr->client);
> +}
> +
> +static const struct auxiliary_device_id qcom_battmgr_id_table[] =3D {
> +	{ .name =3D "pmic_glink.power-supply", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(auxiliary, qcom_battmgr_id_table);
> +
> +static struct auxiliary_driver qcom_battmgr_driver =3D {
> +	.name =3D "pmic_glink_power_supply",
> +	.probe =3D qcom_battmgr_probe,
> +	.id_table =3D qcom_battmgr_id_table,
> +};
> +
> +module_auxiliary_driver(qcom_battmgr_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm PMIC GLINK battery manager driver");
> +MODULE_LICENSE("GPL");
> --=20
> 2.25.1
>=20

--vndmwne3325nqbgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPqnTYACgkQ2O7X88g7
+ppdtBAAj6xHKQ7u2cRnIpZhzX4Ecd0ouFIVsCYQkoGlfUd9rXd9bOaPo3MDHB8s
O7tNroTvuZZg9gbSfHp2yth3v3WOoGv4lAvn+OV5mrPLJPmKhMiksI7oPYwGMQ0u
EwHCvo0z5MKWWajXjznwCP2bD8VcHTdfIKcVjw6RLpYjQK4qXJJhKmXpt9RKnoxI
SPowTapPFnRFusLntKKUvcLoJJNg9952cfVbD7yK0tsJefvmB80yGsahaxeB1UD4
pvXCPqPVj2aHgZVs+8y/qAEwwemXxPFYuho54Ctj6WKtBK0HcVcfKrhcQXW8Xh0z
f46pSBY06VQPP4uBnmxUZKVwLAjxVEJyFJQFBmdsfnck6ipaxthsH7GTNWtQZdWS
e9Aup4T9jH5scp+bT8r325pjvdMThS7D7q7Dq6uDYps5JQxtsojB3sdMeP4k8bIu
VRN5JwBvW2sWx49ez0B+6+B4dbciOmQyp+zBq1wVNZXY5AGjjRedg3XvAAwjk3J3
ilvpcDNybQF3Rgr4agrbgfNnhUEuV/JzsjvuFOLurPRa/sPcbndVrUA3ONPzbcye
v8ffksxvrY3pLy+WzJiO+ZINOJK8GrQ3nVLXk6Z9GpH3nEiOQ07hKxtwwkGGuVYX
VrrNdorLA4cRs1Gupi4hcAqYgXcb8luYzzZPegMQwgwNwQButDM=
=0w8b
-----END PGP SIGNATURE-----

--vndmwne3325nqbgp--
