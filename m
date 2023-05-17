Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4EA705EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjEQExt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjEQExr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:53:47 -0400
X-Greylist: delayed 507 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 21:53:45 PDT
Received: from sv12718.xserver.jp (sv12718.xserver.jp [183.181.96.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE5192
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:53:45 -0700 (PDT)
X-Virus-Status: clean(F-Secure/fsigk_smtp/521/virusgw12003.xserver.jp)
Received: from [127.0.0.1] (ec2-54-250-240-175.ap-northeast-1.compute.amazonaws.com [54.250.240.175])
        by sv12718.xserver.jp (Postfix) with ESMTPSA id 3062E669F4C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:45:17 +0900 (JST)
Content-Type: text/plain; charset=utf-8
From:   "vger.kernel.org" <adm-linux-kernel@liverest.co.jp>
To:     linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Vger__=E3=83=A1=E3=83=BC=E3=83=AB?=
 =?UTF-8?Q?=EF=BC=88linux-kernel=40vger=2Ekernel=2E?=
 =?UTF-8?Q?org=EF=BC=89=E3=81=AE=E8=A8=AD=E5=AE=9A?=
 =?UTF-8?Q?=E7=A2=BA=E8=AA=8D=E3=81=AE=E3=81=8A?=
 =?UTF-8?Q?=E9=A1=98=E3=81=84?=
Message-ID: <d8a5f2a8-4f86-a221-e926-200adb6bb88e@liverest.co.jp>
X-Priority: 1 (Highest)
X-Msmail-Priority: High
Importance: High
Content-Transfer-Encoding: base64
Date:   Wed, 17 May 2023 04:45:17 +0000
MIME-Version: 1.0
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,
        PDS_BRAND_SUBJ_NAKED_TO,PDS_FRNOM_TODOM_NAKED_TO,
        PDS_FROM_NAME_TO_DOMAIN,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: empireburger.ca]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  1.9 PDS_FROM_NAME_TO_DOMAIN From:name looks like To:domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 PDS_FRNOM_TODOM_NAKED_TO Naked to From name equals to Domain
        *  1.0 PDS_BRAND_SUBJ_NAKED_TO Subject starts with To: brand and naked
        *       To:
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQrjgYrlrqLmp5jlkITkvY3jgIENCuKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKU
geKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKU
geKUgeKUgeKUgeKUgQ0Kdmdlci5rZXJuZWwub3JnIOOBi+OCieOBrumHjeimgeOBquOBiuefpeOC
ieOBmw0K4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB
4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSBDQoN
ClZnZXIg44KS44GU5Yip55So44GE44Gf44Gg44GN44GC44KK44GM44Go44GG44GU44GW44GE44G+
44GZ44CCDQoNCnZnZXIua2VybmVsLm9yZyDjga/jgIEyMDIz5bm0NeaciDIw5pel5Lul6ZmN44CB
44CMVmdlciDjg6Hjg7zjg6vjgI3jga7jgrXjg7zjg5Pjgrnku5Xmp5jjgpLkuIDpg6jlpInmm7Tj
gYTjgZ/jgZfjgb7jgZnjgIINCg0KDQrjgZnjgbnjgabjga7jgYrlrqLmp5jjga/jgIHku6XkuIvj
ga7jg6rjg7Pjgq/jgYvjgonjg63jgrDjgqTjg7PjgZfjgabjgIHmlrDjgZfjgYToqK3lrprjgavm
m7TmlrDjgZnjgovlv4XopoHjgYzjgYLjgorjgb7jgZnjgIINCg0KDQoNCmh0dHBzOi8vZW1waXJl
YnVyZ2VyLmNhL3dtLmZyZWViaXQubmV0L3dlYm1haWwuanA/dWlkPWxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCg0KDQoNCnZnZXIua2VybmVsLm9yZyDku6XkuIvjga7kuKHmlrnjga7mnaHk
u7bjgpLmuoDjgZ/jgZXjgarjgYTjg6Hjg7zjg6vjga/jg6Hjg7zjg6vjg5zjg4Pjgq/jgrnjgYvj
gonliYrpmaTjgZXjgozjgb7jgZnjgIINCg0KDQogICAgICBbdmdlci5rZXJuZWwub3JnIOODoeOD
vOODq+OBjCBXZWIg44Oh44O844Or44GnIDkwIOaXpemWk+S9v+eUqOOBleOCjOOBquOBi+OBo+OB
n+WgtOWQiA0KDQogICAgICDjg6Hjg7zjg6vjgr3jg5Xjg4go44OR44K944Kz44OzL+OCueODnuOD
vOODiOODleOCqeODsynjgadWZ2Vy44Oh44O844Or44Gu6YCB5Y+X5L+h44GMOTDml6XplpPjgarj
gYvjgaPjgZ/loLTlkIgNCg0KDQrku4rlvozjgajjgoIgdmdlci5rZXJuZWwub3JnIOOCkuOBlOaE
m+mhp+iznOOCiuOBvuOBmeOCiOOBhuOBiumhmOOBhOeUs+OBl+S4iuOBkuOBvuOBmeOAgg0KDQri
lIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIENClZn
ZXIg44Kr44K544K/44Oe44O8IOOCteODneODvOODiA0KDQrilqHjgYrpm7voqbHjgafjga7jgYrl
lY/jgYTlkIjjgo/jgZsNCnZnZXIua2VybmVsLm9yZyDjgqvjgrnjgr/jg57jg7wg44K144Od44O8
44OIIOOCpOODs+ODleOCqeODoeODvOOCt+ODp+ODsyDjg4fjgrnjgq8NCu+8iOWPl+S7mOaZgumW
kyAzNjXml6UgOTowMO+9njE4OjAw77yJDQowMTIwLTg2LTAwMDDvvIjjg5Xjg6rjg7zjg4DjgqTj
g6Tjg6vvvIkNCjAzLTYzODUtMDAwMO+8iOacieaWme+8iSDigLvmkLrluK/pm7voqbHjg7tQSFPj
g7tJUOmbu+ipseOBruWgtOWQiA0KDQrjgZPjga7jg6Hjg7zjg6vjga/lsILnlKjjga7jg6Hjg7zj
g6vjgqLjg4njg6zjgrnjgYvjgonpgIHkv6HjgZXjgozjgb7jgZnjgIINCuKUgeKUgeKUgeKUgeKU
geKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgQ0KQ29weXJpZ2h0KEMpIFZn
ZXIgSW5jLiAyMDIzDQoNCg0K44Kr44Oz44OV44Kh44Os44Oz44K5OiBUUl9TX0FfU0VDVVJJVFlf
Q0hFQ0tfTUFJTA0K
