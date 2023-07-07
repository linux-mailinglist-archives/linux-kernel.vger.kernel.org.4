Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CED74B59F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGGRPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjGGRPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:15:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60882121;
        Fri,  7 Jul 2023 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1688750094; x=1689354894; i=ps.report@gmx.net;
 bh=TFEwpLvvzTAfrxGUI2U7EdMsAJw2n6EQAhuJtdUWuDk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=p2XwhJOio5z3VSr+dZOpoJIXP+c8R20g2+heWzqbOgDyb/lZRL4VIwY6IeYULro+IhbJo7H
 mMV98LpCnbkQMkoyGQn01HRzJDcKTkdv+vHZ8tUK3OSQTipYIFBHKNyG65i7A8v2X2yfMNF9a
 Ma72eYGFeFag5k8azRIccOMwli2QwS6boEs80NsmyEJlXLnGp15zL8V/xqOCFhLYiJ/oeS1o9
 9YpKWNHKYAKbotrbWtXlZtdc9S0FlLYcIpuP8hd+y1pxXdKmalDwOKvXDTzQSDa+Fsi86C8px
 RhNnpDhZjN636KRLXptoE4GgtH6w76+/qizyq6qhI5Qx7Gk1P4YQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([62.216.208.106]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N8XU1-1pwDlf1rPN-014Qyq; Fri, 07 Jul 2023 19:14:54 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     linux-can@vger.kernel.org
Cc:     Markus Marb <marm@hms-networks.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        socketcan@hms-networks.de, linux-kernel@vger.kernel.org,
        Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH v10 2/3] can: usb: ixxat_usb: add USB2CAN_PLUGIN_PRODUCT_ID (IXXAT USB Plugin)
Date:   Fri,  7 Jul 2023 19:14:12 +0200
Message-ID: <20230707171412.31195-3-ps.report@gmx.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707171412.31195-2-ps.report@gmx.net>
References: <20230707171412.31195-2-ps.report@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:0GxF0H+iXmJwje6p57jdODclDXZjBLOHMwpeB5hZ7UJL55oCISA
 OhyyVp0S70qZ88qrPKQlHjBUl8+sts4gNkTcL+X7zIMWl7H0TPhtS3NJDnIeblAN8KO+ree
 +MkhYsY7Vj8rYBfX2/eu+l9mk0lRbpGb2nMeGDv5n5acMTCQbgkkFFG5PtlzFvhl5mdjRYy
 HxFL5wbUvKp5GlzxGRFOQ==
UI-OutboundReport: notjunk:1;M01:P0:ebzHRj+M22o=;UA3OHxg8/WIVCHlxKG8g9bIQab3
 lo3ewsAI+GgCO9mnPWc2WBRv75CbBv5hBtKvZ8r2pdjMTgltRz8dvGpjsrNZI0dTswXyOSn/B
 yc6jvo+s2so3KuaSliKqQSNc2EyXKsf9T337757BB3CrMqVSpl+1zwfcCH4JjsLvP22oGQj/N
 U67IJt1uO+Q65JCB2jI+6I6cDtHT3b22kawHHhFCr4qBHk0D+J6eXYUOrTLh5i4hHL+oZ3tsI
 AQwBiyKC6uJituNr37t9A17bIdebsXnHB5wyXJSjaYL9d8qjmUDNwFVjeaGbw5n8KDdoktmBN
 OvZFkPJ6BGD3qIBza49dvhCjos3x4atcbevQ6QWCbjG+ycspRUGp6+udqTSxVh7ejScrgwvlL
 aFnOFHraGtlPbjfWkvs0szhrYpnrLjMQ/U0F+mE4t4W7BTWmDJrQVD1gbQ5EQgpvHBoZCS+Bd
 v3FdCXpPudc2GTZ3FKozVs1FdE2u1N0XrrCILW0V1JtMqcLCvz05Cw0QXEktoQ2aTnSZ89baO
 T7ywCU3bjHS/yESoqHaOxatx+AqZ60FtHfrGpUUR99BBEb/fIHM+1XfTekwCb/UFI9ApY4zqU
 0xkRWPZsHL+5XJ+Vi1B64tOBkCwy9wqUfhPy0ML9T6pQui/IfoWblzXv8SODQTW0prccH2u74
 8Nc5GgnQsk93vw/SdkTwX/WifQqP2lhz6ubVvxbFadWbLGeWrBibaiMliBqnhyprU9NAhQkc1
 qxXntK2+BZTCcV9sfGEueMp/99uET9EnQSCgFaM1tC/j9J+MWmR8V6rtw16a3ZpgI9408ChV0
 INiJgNqNqN52M2ZRwuAigXLq7ED0pzaVUy5GuG8iyMpLgNl8UAYQpl0mcqlGyN7VBldKS2r9S
 OzTpuitU5w+oFvcrvAHxw+1x25EjD4rFM1ZsN9Dq80DXyZxyZNrCTGOBqZpg9kd6u/GHfSCaH
 YwmkmYre/MAOGyHjjgfD6kbav2U=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LSBhZGQgVVNCMkNBTl9QTFVHSU5fUFJPRFVDVF9JRCAoSVhYQVQgVVNCIFBsdWdpbikgc3VwcG9y
dAogIChiYWNrcG9ydGVkIGZyb20gdXBzdHJlYW0gZHJpdmVyIGl4X3VzYl9jYW5fMi4wLjM2Ni1S
RUwpCgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+Ci0t
LQpDaGFuZ2VzIHY5IC0+IHYxMCAoUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0Pik6
CiAgLSBuZXcgcGF0Y2gKLS0tCiBkcml2ZXJzL25ldC9jYW4vdXNiL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgIHwgMSArCiBkcml2ZXJzL25ldC9jYW4vdXNiL2l4eGF0X3VzYi9peHhhdF91c2Jf
Y29yZS5jIHwgMiArKwogZHJpdmVycy9uZXQvY2FuL3VzYi9peHhhdF91c2IvaXh4YXRfdXNiX2Nv
cmUuaCB8IDEgKwogMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9jYW4vdXNiL0tjb25maWcgYi9kcml2ZXJzL25ldC9jYW4vdXNiL0tjb25m
aWcKaW5kZXggZGE0YjQ5YjMxOGQyLi4zNGRlYWE3NmYzYTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
bmV0L2Nhbi91c2IvS2NvbmZpZworKysgYi9kcml2ZXJzL25ldC9jYW4vdXNiL0tjb25maWcKQEAg
LTcyLDYgKzcyLDcgQEAgY29uZmlnIENBTl9JWFhBVF9VU0IKIAkgICAgLSBJWFhBVCBVU0ItdG8t
Q0FOIGVtYmVkZGVkCiAJICAgIC0gSVhYQVQgVVNCLXRvLUNBTiBwcm9mZXNzaW9uYWwKIAkgICAg
LSBJWFhBVCBVU0ItdG8tQ0FOIGF1dG9tb3RpdmUKKwkgICAgLSBJWFhBVCBVU0ItdG8tQ0FOIHBs
dWdpbgogCSAgICAtIElYWEFUIFVTQi10by1DQU4gRkQgY29tcGFjdAogCSAgICAtIElYWEFUIFVT
Qi10by1DQU4gRkQgcHJvZmVzc2lvbmFsCiAJICAgIC0gSVhYQVQgVVNCLXRvLUNBTiBGRCBhdXRv
bW90aXZlCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vdXNiL2l4eGF0X3VzYi9peHhhdF91
c2JfY29yZS5jIGIvZHJpdmVycy9uZXQvY2FuL3VzYi9peHhhdF91c2IvaXh4YXRfdXNiX2NvcmUu
YwppbmRleCBjMjcyOGY2ZDNmZDAuLjg5NDgzNmJkZWVkMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9u
ZXQvY2FuL3VzYi9peHhhdF91c2IvaXh4YXRfdXNiX2NvcmUuYworKysgYi9kcml2ZXJzL25ldC9j
YW4vdXNiL2l4eGF0X3VzYi9peHhhdF91c2JfY29yZS5jCkBAIC0yNiw2ICsyNiw4IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgdXNiX2RldmljZV9pZCBpeHhhdF91c2JfdGFibGVbXSA9IHsKIAkgIC5k
cml2ZXJfaW5mbyA9IChrZXJuZWxfdWxvbmdfdCkmdXNiMmNhbl9jbDEsIH0sCiAJeyBVU0JfREVW
SUNFKElYWEFUX1VTQl9WRU5ET1JfSUQsIFVTQjJDQU5fQVVUT01PVElWRV9QUk9EVUNUX0lEKSwK
IAkgIC5kcml2ZXJfaW5mbyA9IChrZXJuZWxfdWxvbmdfdCkmdXNiMmNhbl9jbDEsIH0sCisJeyBV
U0JfREVWSUNFKElYWEFUX1VTQl9WRU5ET1JfSUQsIFVTQjJDQU5fUExVR0lOX1BST0RVQ1RfSUQp
LAorCSAgLmRyaXZlcl9pbmZvID0gKGtlcm5lbF91bG9uZ190KSZ1c2IyY2FuX2NsMSwgfSwKIAl7
IFVTQl9ERVZJQ0UoSVhYQVRfVVNCX1ZFTkRPUl9JRCwgVVNCMkNBTl9GRF9DT01QQUNUX1BST0RV
Q1RfSUQpLAogCSAgLmRyaXZlcl9pbmZvID0gKGtlcm5lbF91bG9uZ190KSZ1c2IyY2FuX2NsMiwg
fSwKIAl7IFVTQl9ERVZJQ0UoSVhYQVRfVVNCX1ZFTkRPUl9JRCwgVVNCMkNBTl9GRF9QUk9GRVNT
SU9OQUxfUFJPRFVDVF9JRCksCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vdXNiL2l4eGF0
X3VzYi9peHhhdF91c2JfY29yZS5oIGIvZHJpdmVycy9uZXQvY2FuL3VzYi9peHhhdF91c2IvaXh4
YXRfdXNiX2NvcmUuaAppbmRleCBhNmVhNmQ2ODIyODIuLjU4MTBjNDgxYTg3NSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9uZXQvY2FuL3VzYi9peHhhdF91c2IvaXh4YXRfdXNiX2NvcmUuaAorKysgYi9k
cml2ZXJzL25ldC9jYW4vdXNiL2l4eGF0X3VzYi9peHhhdF91c2JfY29yZS5oCkBAIC0xNSw2ICsx
NSw3IEBACiAjZGVmaW5lIFVTQjJDQU5fRU1CRURERURfUFJPRFVDVF9JRCAweDAwMDkKICNkZWZp
bmUgVVNCMkNBTl9QUk9GRVNTSU9OQUxfUFJPRFVDVF9JRCAweDAwMEEKICNkZWZpbmUgVVNCMkNB
Tl9BVVRPTU9USVZFX1BST0RVQ1RfSUQgMHgwMDBCCisjZGVmaW5lIFVTQjJDQU5fUExVR0lOX1BS
T0RVQ1RfSUQgMHgwMDFGCiAKIC8qIHN1cHBvcnRlZCBkZXZpY2UgaWRzOiBDTDIgKi8KICNkZWZp
bmUgVVNCMkNBTl9GRF9DT01QQUNUX1BST0RVQ1RfSUQgMHgwMDE0Ci0tIAoyLjQxLjAKCg==
