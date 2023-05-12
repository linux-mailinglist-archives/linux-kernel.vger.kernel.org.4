Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A305700893
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbjELNEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240817AbjELNEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:04:05 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0E5903F
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1683896641; i=spasswolf@web.de;
        bh=1KdcxEksoHe7uSmO3F66VNaLA+6Sq7J+nbN+SgeL/lg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=PtVeS3GbfZ5cWYV5p8c69E7M7r62kq5Vvj+naM3D1X5cepKn3yWuKiLxpAKhXHkIw
         701N+UK7Jh1DGjZnMZuMAmvgr48Nru8ABIbk4481N1gq+r9UZ3rrCPyOm7Cw3WJKvu
         QOh3uL8EBnqsCcW/+QDyIXRU+TKxeV0bZ+BVCLjR6HVzpHnlKe78Mj5p/Si7zEWBiU
         zpZdKgxNI51izm/98kegUJmtZFIX5MtQ4cRwkJRsonnYsx19BLeqzxaSuKafWzO5vP
         HbuNlJ5o+8FKtTXoEAl9XgpRqdyVm2376H7jnaXuTjavTzd+ZgvW9JOaRWBP/tsi1w
         CWpNk0dyvNccA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6sBv-1qG28d40jv-0184L3; Fri, 12
 May 2023 15:04:01 +0200
Message-ID: <8a1beef0bc605756f8a45acf86f6bb58c188ae21.camel@web.de>
Subject: IPA_STATUS_SIZE, commit b8dc7d0eea5a7709bb534f1b3ca70d2d7de0b42c
From:   Bert Karwatzki <spasswolf@web.de>
To:     linux-kernel@vger.kernel.org
Cc:     Alex Elder <elder@linaro.org>
Date:   Fri, 12 May 2023 15:04:00 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Provags-ID: V03:K1:EmFpm0D0FEsWitNTOhk/JLY+I+gr35gBfHXTz8dHvu/YUdrIzVH
 YJUx28G9IL3ESzPv4aWh1ntOxmt51NK/+K3mK0bsPWbN8mEChBIz6ZUfKi6/GJ34kbg/oFU
 N/+dFjZm3XSm5sHOWTgdzNio+/8LAbd7hXh8YBt1GtUcxiTZZlrg4Yh6s8zmSiJA0Hys9T9
 1EvOf/TxNsht870RUCGhA==
UI-OutboundReport: notjunk:1;M01:P0:Bsroi17nSiw=;j90CJwbh3/83tjhA21agfUY8r5b
 RfYv4jRqedpa1avPPT5ZWS/e2B7gKHcmdq1rWIidlvR8/rk6SE1HR+Ws7UqliuLsf2yyWs3Mr
 h+TNY1+XUFRrpcQdcZoi68ty2rHq/Xjq6CoQ21+375paSLHJLTX+mREfUsnvGka/YSGO43tDN
 MYNVP+0GaAvMYWIaXBwd8oTdg2/ePyQZ0VXt7qKSH/6/n/QczpmcKWviezoBf6PNzMPB7f43h
 g55XC/h20RX+CYZfebOPcae80Qw5yTlw4JGmUgNc8LGfApw8l+POVmEbXxlQgHZZOVT9nIokw
 1T7f2zpGmUx6Ata3aBaLq4pCPdlAMUVob5oMh659OZHuajlo2NFTlZKrgvK2JF1D6/u1J2i40
 SIkuq65FjQ00/SMZsd9dKDDaO7cIVe+VxCkDIFWnqQA4ejUhVO/rRlUVI0OSI5bFN8VYw9ZXF
 FDKhCP8rriXiyrUUqa+Wmzcjs48kzpkr9e0igdWYjvo9A4c6+K8MTLLHNybsQh1kEtYOdJW/d
 Sfj0gI5ZeOTeyF1L9tspHD4wh4RrnTC6Ys1TFYm5xxBaiA3fF9E0p9NbbM7rnP560WCckT9os
 pU7Ews+vAjK3TUqcHc/c5+M8T27n4EKa+Veprszi2B5VLgsGVksAtGmagnRKTkncA3DMhJD5f
 ji/hKMUgQ76vEnvAgfm4txB4Yr0QFSYiE1Hr8CdeR++cE10oekcXljYCY14nLZL/PcV7N72QG
 OKF0aM5ZDOt8/ymK+DpR4pny5swdvWka3DTbV4cdJR7XwIKF0tknGCYikP5c0asGTwwH+9KKC
 +rTuCNYTZ8GoLRjwR8sLDry3tb6FSfmlFYh7M8fjRJ+4xNfD5/2deT+/y04V2M9ku+daFpDJw
 +KJ4CvBn/ZwTDujfiznCUe2uUfUaq7sYAaiP4mAcouyvceEXfllGAsNSqhRtOmDABIH7d6yQA
 aERCEHjs1+2lENa9e5Om17Kqas0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b8dc7d0eea5a7709bb534f1b3ca70d2d7de0b42c
Author: Alex Elder <elder@linaro.org>
Date:   Wed Jan 25 14:45:39 2023 -0600

    net: ipa: stop using sizeof(status)
   =20
    The IPA packet status structure changes in IPA v5.0 in ways that
are
    difficult to represent cleanly.  As a small step toward redefining
    it as a parsed block of data, use a constant to define its size,
    rather than the size of the IPA status structure type.
   =20
    Signed-off-by: Alex Elder <elder@linaro.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

introduced the IPA_STATUS_SIZE constant as a replacent for
sizeof(struct ipa_status). IPA_STATUS_SIZE is defined as
sizeof(__le32[4]), but sizeof(struct ipa_status) =3D sizeof(__le32[8])
and the newly introducded ipa_status_extract operates on 8 __le32
words, so I wondered if IPA_STATUS_SIZE is correct.

Bert Karwatzki
