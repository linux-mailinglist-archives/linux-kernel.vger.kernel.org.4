Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDB73A932
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjFVTys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFVTyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:54:45 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395ED1A4;
        Thu, 22 Jun 2023 12:54:44 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b46f1256bbso12658811fa.0;
        Thu, 22 Jun 2023 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687463682; x=1690055682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/cadoL91UgIvVLuoFs4i82e6qRN/IaFUQ5NJpgb2B0=;
        b=UVT8p283LYMg8n7rkCQBZlQnyEuskPtvb6pfQBla57j+DbVw4XzRI+TbCeG8O41fs6
         UYdm5DEEJd+mLoWvpEqlUnet1VJuh7tgUSEdxPb6habJCEtajE8YXQejDk7L32DAnJPF
         +TlNP0bxJAdb7S3mgiJNeKCPBEDcu8FjDneMiyHR2vMi50fWaeDWXaqJZp52endecmQQ
         rHv99dIdGxR5deugNW6tYpOXpOPnmyXXsijyivnd4Yp1Q2f6IpGA+qI3bujBKUam5XTS
         UqkChdGJpKVC52z8M4tEs06gRFzKNiYYFxlPPBh/yj4ccD3UVBKVxjPjT02jg3/wtKkq
         KVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687463682; x=1690055682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/cadoL91UgIvVLuoFs4i82e6qRN/IaFUQ5NJpgb2B0=;
        b=W1ApinVZEuekFwW6ax08IcK9eQHfIVcozAjBbeOu/63SJd+ffupeIXEORemQaK6cCi
         KvzH05G2aSHiFHl8rsX1bw2bla0mKUVC7IkXkr+ZHqdOX4jSezO83dbZRvuElwG/mbMB
         EBODqef6BsgIHRg4vGYEmP3S5lZ9a+xAZMMuDrppTMSDEcU+LXmhy233TvYIPmxn4FcN
         dHVPmY7C7tFACe7xFVeOmjBkzplBTp8j3iilkkrkd71LOd2U6QRMqeaTpw96g+88/Vew
         xlFLqGy7Y/T0/leEvTNmf0RK3+3PzXmE63dZyWpYXi5UXvmwkfgYD4M8iAVGzL8PRB5h
         bnKw==
X-Gm-Message-State: AC+VfDx3iV/DXi5nYrLkT8GZ+CLOgTRoDJz/vHrSoYf+fQBKE9QbG9a1
        RwUoZ+KuOjKDCK0aUwCuafuV5Orn5HnqHno2GzU=
X-Google-Smtp-Source: ACHHUZ7OqITQcRTPJVTI9gJ15k7ERoTJ0gIKMn/JSKldylDcQU6kUiVQG/9a+dOKZbfI+GFVtciQmolkcTeY8etsUCs=
X-Received: by 2002:a05:6512:31c9:b0:4f8:5e4e:52ad with SMTP id
 j9-20020a05651231c900b004f85e4e52admr5728828lfe.23.1687463682047; Thu, 22 Jun
 2023 12:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org>
 <20230620-topic-sm8550-upstream-bt-v1-2-4728564f8872@linaro.org> <b56bdd22-7d68-8a48-4207-ca6b83ec2644@linaro.org>
In-Reply-To: <b56bdd22-7d68-8a48-4207-ca6b83ec2644@linaro.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 22 Jun 2023 12:54:29 -0700
Message-ID: <CABBYNZ+JRbvOKnup0dH8V7YBpYcGuSn00i7zPhKP=3M3rEfF7Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] bluetooth: qca: add support for WCN7850
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil

On Tue, Jun 20, 2023 at 8:43=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> On 20.06.2023 17:19, Neil Armstrong wrote:
> > Add support for the WCN7850 Bluetooth chipset.
> >
> > Tested on the SM8550 QRD platform.
> >
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> I don't have comments for this patch specifically, but:
>
>
> >  drivers/bluetooth/btqca.c   |  7 +++++++
> >  drivers/bluetooth/btqca.h   | 10 ++++++++++
> >  drivers/bluetooth/hci_qca.c | 48 ++++++++++++++++++++++++++++++++++---=
--------
> >  3 files changed, 54 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> > index e7e58a956d15..037146b476ff 100644
> > --- a/drivers/bluetooth/btqca.c
> > +++ b/drivers/bluetooth/btqca.c
> > @@ -617,6 +617,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t ba=
udrate,
> >       } else if (soc_type =3D=3D QCA_WCN6855) {
> >               snprintf(config.fwname, sizeof(config.fwname),
> >                        "qca/hpbtfw%02x.tlv", rom_ver);
> > +     } else if (soc_type =3D=3D QCA_WCN7850) {
> > +             snprintf(config.fwname, sizeof(config.fwname),
> > +                      "qca/hmtbtfw%02x.tlv", rom_ver);
> >       } else {
> >               snprintf(config.fwname, sizeof(config.fwname),
> >                        "qca/rampatch_%08x.bin", soc_ver);
> > @@ -654,6 +657,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t ba=
udrate,
> >       else if (soc_type =3D=3D QCA_WCN6855)
> >               snprintf(config.fwname, sizeof(config.fwname),
> >                        "qca/hpnv%02x.bin", rom_ver);
> > +     else if (soc_type =3D=3D QCA_WCN7850)
> > +             snprintf(config.fwname, sizeof(config.fwname),
> > +                      "qca/hmtnv%02x.bin", rom_ver);
> >       else
> >               snprintf(config.fwname, sizeof(config.fwname),
> >                        "qca/nvm_%08x.bin", soc_ver);
> The above changes should probably be made switch statements as well
>
> > @@ -695,6 +701,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t ba=
udrate,
> >       case QCA_WCN3991:
> >       case QCA_WCN6750:
> >       case QCA_WCN6855:
> > +     case QCA_WCN7850:
> >               /* get fw build info */
> >               err =3D qca_read_fw_build_info(hdev);
> >               if (err < 0)
> > diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> > index b884095bcd9d..ff1850e984fe 100644
> > --- a/drivers/bluetooth/btqca.h
> > +++ b/drivers/bluetooth/btqca.h
> > @@ -148,6 +148,7 @@ enum qca_btsoc_type {
> >       QCA_QCA6390,
> >       QCA_WCN6750,
> >       QCA_WCN6855,
> > +     QCA_WCN7850,
> >  };
> >
> >  #if IS_ENABLED(CONFIG_BT_QCA)
> > @@ -173,6 +174,10 @@ static inline bool qca_is_wcn6855(enum qca_btsoc_t=
ype soc_type)
> >  {
> >       return soc_type =3D=3D QCA_WCN6855;
> >  }
> > +static inline bool qca_is_wcn7850(enum qca_btsoc_type soc_type)
> > +{
> > +     return soc_type =3D=3D QCA_WCN7850;
> > +}
> >
> >  #else
> >
> > @@ -216,6 +221,11 @@ static inline bool qca_is_wcn6855(enum qca_btsoc_t=
ype soc_type)
> >       return false;
> >  }
> >
> > +static inline bool qca_is_wcn7850(enum qca_btsoc_type soc_type)
> > +{
> > +     return false;
> > +}
> > +
> >  static inline int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
> >  {
> >       return -EOPNOTSUPP;
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index e30c979535b1..49b8d75d271e 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1322,7 +1322,8 @@ static int qca_set_baudrate(struct hci_dev *hdev,=
 uint8_t baudrate)
> >       /* Give the controller time to process the request */
> >       if (qca_is_wcn399x(qca_soc_type(hu)) ||
> >           qca_is_wcn6750(qca_soc_type(hu)) ||
> > -         qca_is_wcn6855(qca_soc_type(hu)))
> > +         qca_is_wcn6855(qca_soc_type(hu)) ||
> > +         qca_is_wcn7850(qca_soc_type(hu)))
> >               usleep_range(1000, 10000);
> Separate topic, but I see usages of the helper and raw comparisons
> everywhere.. I'd vote for switch everywhere

+1, most of the time it is preferable to go with switches which makes
the code cleaner/more readable, Im fine not requiring it in this set
but I hope someone looks into doing some cleanup in this code.

> Konrad
> >       else
> >               msleep(300);
> > @@ -1400,7 +1401,8 @@ static int qca_check_speeds(struct hci_uart *hu)
> >  {
> >       if (qca_is_wcn399x(qca_soc_type(hu)) ||
> >           qca_is_wcn6750(qca_soc_type(hu)) ||
> > -         qca_is_wcn6855(qca_soc_type(hu))) {
> > +         qca_is_wcn6855(qca_soc_type(hu)) ||
> > +         qca_is_wcn7850(qca_soc_type(hu))) {
> >               if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
> >                   !qca_get_speed(hu, QCA_OPER_SPEED))
> >                       return -EINVAL;
> > @@ -1435,7 +1437,8 @@ static int qca_set_speed(struct hci_uart *hu, enu=
m qca_speed_type speed_type)
> >                */
> >               if (qca_is_wcn399x(soc_type) ||
> >                   qca_is_wcn6750(soc_type) ||
> > -                 qca_is_wcn6855(soc_type))
> > +                 qca_is_wcn6855(soc_type) ||
> > +                 qca_is_wcn7850(soc_type))
> >                       hci_uart_set_flow_control(hu, true);
> >
> >               if (soc_type =3D=3D QCA_WCN3990) {
> > @@ -1454,7 +1457,8 @@ static int qca_set_speed(struct hci_uart *hu, enu=
m qca_speed_type speed_type)
> >  error:
> >               if (qca_is_wcn399x(soc_type) ||
> >                   qca_is_wcn6750(soc_type) ||
> > -                 qca_is_wcn6855(soc_type))
> > +                 qca_is_wcn6855(soc_type) ||
> > +                 qca_is_wcn7850(soc_type))
> >                       hci_uart_set_flow_control(hu, false);
> >
> >               if (soc_type =3D=3D QCA_WCN3990) {
> > @@ -1691,7 +1695,8 @@ static int qca_power_on(struct hci_dev *hdev)
> >
> >       if (qca_is_wcn399x(soc_type) ||
> >           qca_is_wcn6750(soc_type) ||
> > -         qca_is_wcn6855(soc_type)) {
> > +         qca_is_wcn6855(soc_type) ||
> > +         qca_is_wcn7850(soc_type)) {
> >               ret =3D qca_regulator_init(hu);
> >       } else {
> >               qcadev =3D serdev_device_get_drvdata(hu->serdev);
> > @@ -1733,7 +1738,8 @@ static int qca_setup(struct hci_uart *hu)
> >       bt_dev_info(hdev, "setting up %s",
> >               qca_is_wcn399x(soc_type) ? "wcn399x" :
> >               (soc_type =3D=3D QCA_WCN6750) ? "wcn6750" :
> > -             (soc_type =3D=3D QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390=
");
> > +             (soc_type =3D=3D QCA_WCN6855) ? "wcn6855" :
> > +             (soc_type =3D=3D QCA_WCN7850) ? "wcn7850" : "ROME/QCA6390=
");
> >
> >       qca->memdump_state =3D QCA_MEMDUMP_IDLE;
> >
> > @@ -1746,7 +1752,8 @@ static int qca_setup(struct hci_uart *hu)
> >
> >       if (qca_is_wcn399x(soc_type) ||
> >           qca_is_wcn6750(soc_type) ||
> > -         qca_is_wcn6855(soc_type)) {
> > +         qca_is_wcn6855(soc_type) ||
> > +         qca_is_wcn7850(soc_type)) {
> >               set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> >               hci_set_aosp_capable(hdev);
> >
> > @@ -1769,7 +1776,8 @@ static int qca_setup(struct hci_uart *hu)
> >
> >       if (!(qca_is_wcn399x(soc_type) ||
> >             qca_is_wcn6750(soc_type) ||
> > -           qca_is_wcn6855(soc_type))) {
> > +           qca_is_wcn6855(soc_type) ||
> > +           qca_is_wcn7850(soc_type))) {
> >               /* Get QCA version information */
> >               ret =3D qca_read_soc_version(hdev, &ver, soc_type);
> >               if (ret)
> > @@ -1909,6 +1917,20 @@ static const struct qca_device_data qca_soc_data=
_wcn6855 __maybe_unused =3D {
> >       .capabilities =3D QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STAT=
ES,
> >  };
> >
> > +static const struct qca_device_data qca_soc_data_wcn7850 __maybe_unuse=
d =3D {
> > +     .soc_type =3D QCA_WCN7850,
> > +     .vregs =3D (struct qca_vreg []) {
> > +             { "vddio", 5000 },
> > +             { "vddaon", 26000 },
> > +             { "vdddig", 126000 },
> > +             { "vddrfa0p8", 102000 },
> > +             { "vddrfa1p2", 257000 },
> > +             { "vddrfa1p9", 302000 },
> > +     },
> > +     .num_vregs =3D 6,
> > +     .capabilities =3D QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STAT=
ES,
> > +};
> > +
> >  static void qca_power_shutdown(struct hci_uart *hu)
> >  {
> >       struct qca_serdev *qcadev;
> > @@ -2074,7 +2096,8 @@ static int qca_serdev_probe(struct serdev_device =
*serdev)
> >       if (data &&
> >           (qca_is_wcn399x(data->soc_type) ||
> >            qca_is_wcn6750(data->soc_type) ||
> > -          qca_is_wcn6855(data->soc_type))) {
> > +          qca_is_wcn6855(data->soc_type) ||
> > +          qca_is_wcn7850(data->soc_type))) {
> >               qcadev->btsoc_type =3D data->soc_type;
> >               qcadev->bt_power =3D devm_kzalloc(&serdev->dev,
> >                                               sizeof(struct qca_power),
> > @@ -2105,7 +2128,8 @@ static int qca_serdev_probe(struct serdev_device =
*serdev)
> >                                              GPIOD_IN);
> >               if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
> >                   (data->soc_type =3D=3D QCA_WCN6750 ||
> > -                  data->soc_type =3D=3D QCA_WCN6855))
> > +                  data->soc_type =3D=3D QCA_WCN6855 ||
> > +                  data->soc_type =3D=3D QCA_WCN7850))
> >                       dev_warn(&serdev->dev, "failed to acquire SW_CTRL=
 gpio\n");
> >
> >               qcadev->susclk =3D devm_clk_get_optional(&serdev->dev, NU=
LL);
> > @@ -2182,7 +2206,8 @@ static void qca_serdev_remove(struct serdev_devic=
e *serdev)
> >
> >       if ((qca_is_wcn399x(qcadev->btsoc_type) ||
> >            qca_is_wcn6750(qcadev->btsoc_type) ||
> > -          qca_is_wcn6855(qcadev->btsoc_type)) &&
> > +          qca_is_wcn6855(qcadev->btsoc_type) ||
> > +          qca_is_wcn7850(qcadev->btsoc_type)) &&
> >           power->vregs_on)
> >               qca_power_shutdown(&qcadev->serdev_hu);
> >       else if (qcadev->susclk)
> > @@ -2368,6 +2393,7 @@ static const struct of_device_id qca_bluetooth_of=
_match[] =3D {
> >       { .compatible =3D "qcom,wcn3998-bt", .data =3D &qca_soc_data_wcn3=
998},
> >       { .compatible =3D "qcom,wcn6750-bt", .data =3D &qca_soc_data_wcn6=
750},
> >       { .compatible =3D "qcom,wcn6855-bt", .data =3D &qca_soc_data_wcn6=
855},
> > +     { .compatible =3D "qcom,wcn7850-bt", .data =3D &qca_soc_data_wcn7=
850},
> >       { /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
> >



--=20
Luiz Augusto von Dentz
