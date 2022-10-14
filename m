Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECAB5FF51A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJNVOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJNVOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:14:18 -0400
Received: from raifjvws.internetkoala.com (raifjvws.internetkoala.com [85.217.145.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E531DB253
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=internetkoala.com;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; i=sie.ran@internetkoala.com;
 bh=Z0f06KQGAaOTgFGn3AiCUImx+Jg=;
 b=NceMg5A/D5Ay4dus/huDW646KGjPEtQWq3ou8ciUU6KgIAf2/vPfr96piiZ3lwx/Q9zICrKEZaRy
   6rH/bql9LQLSd+huzs0EBQX043GpoWeCTiR5QjYV614PXepuAa4jfHAIMHM6cEnZZLVGH/RtPvI3
   yN24Me1KVxdhTtrO1DDHas/vrB7ipGVEu/mJq5xrQd6P5JM2gGjnaVHCh2e5ove3bvZ0Vdgaho0T
   pSDWv1cai90/sNWOsI1l/7nRP4ZuAbTydM+/A0KwnumArK6YHc3lSuV+igQTQr5l/Xrw2GnAtmo1
   iCFHJYVuf1pc/k8cqpBGMNozLQISf/500XDKvQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=internetkoala.com;
 b=QbBKZk+gSRRM1oESpJPdCuHHWfVfX8MRrbAfZ3G/2GjUZkl28+DFz2EdP1SXHkbunwpnBIkK1gZs
   6AExrh9u5LzGjvg5/+ex2NCntuVVLyTuWfRt7HT04zy7/J1cllUI7v9VCn/d+r7rlypUL2pQ0dyk
   Rz7Ngijrclv8qVOXoLyLKMwQZCzyt+dZUm/X6vxJAb8gIlaUE9KWNOpEDW+LKyeXnv6zgcuTSUBL
   yWJ/Vjn1OhfU2pu1QuAxwRtldcT7Im8WN2i0prcfCE/6mhZ2u45dsGBU7ozlAfRl4PKYtstZKOWg
   vIZHrLBjuAPqiwMI3QQ+66vGzXY1G6eIORZeeQ==;
From:   linux-kernel <sie.ran@internetkoala.com>
To:     linux-kernel@vger.kernel.org
Subject: Document 14 Oct 2022
Date:   14 Oct 2022 14:14:17 -0700
Message-ID: <20221014141417.23FD3975577C5CEA@internetkoala.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_0012_97D5F70D.0F0AA8D6"
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_HTML_ATTACH,
        T_OBFU_ATTACH_MISSP,T_OBFU_HTML_ATTACH,T_TVD_MIME_NO_HEADERS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  1.7 URIBL_BLACK Contains an URL listed in the URIBL blacklist
        *      [URIs: internetkoala.com]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6772]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [85.217.145.178 listed in bl.score.senderscore.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 T_OBFU_HTML_ATTACH BODY: HTML attachment with non-text MIME
        *      type
        *  0.0 T_TVD_MIME_NO_HEADERS BODY: No description available.
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [85.217.145.178 listed in wl.mailspike.net]
        *  0.0 T_HTML_ATTACH HTML attachment to bypass scanning?
        *  0.0 T_OBFU_ATTACH_MISSP Obfuscated attachment type and misspaced
        *      From
        *  2.0 MIME_NO_TEXT No (properly identified) text body parts
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0012_97D5F70D.0F0AA8D6

------=_NextPart_000_0012_97D5F70D.0F0AA8D6
Content-Type: application/octet-stream; name="linux-kernel@vger.kernel.org.shtml"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-kernel@vger.kernel.org.shtml"

PEhUTUw+PEhFQUQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0
ZXh0L2h0bWw7IGNoYXJzZXQ9aXNvLTg4NTktMSI+DQoNCjxTVFlMRSB0eXBlPXRleHQvY3Nz
Pg0KYm9keSwgaHRtbCB7aGVpZ2h0OiAxMDAlO21hcmdpbjogMDsgIGZvbnQtZmFtaWx5OiAi
U2Vnb2UgVUkgV2ViZm9udCIsLWFwcGxlLXN5c3RlbSwiSGVsdmV0aWNhIE5ldWUiLCJMdWNp
ZGEgR3JhbmRlIiwiUm9ib3RvIiwiRWJyaW1hIiwiTmlybWFsYSBVSSIsIkdhZHVnaSIsIlNl
Z29lIFhib3ggU3ltYm9sIiwiU2Vnb2UgVUkgU3ltYm9sIiwiTWVpcnlvIFVJIiwiS2htZXIg
VUkiLCJUdW5nYSIsIkxhbyBVSSIsIlJhYXZpIiwiSXNrb29sYSBQb3RhIiwiTGF0aGEiLCJM
ZWVsYXdhZGVlIiwiTWljcm9zb2Z0IFlhSGVpIFVJIiwiTWljcm9zb2Z0IEpoZW5nSGVpIFVJ
IiwiTWFsZ3VuIEdvdGhpYyIsIkVzdHJhbmdlbG8gRWRlc3NhIiwiTWljcm9zb2Z0IEhpbWFs
YXlhIiwiTWljcm9pbHNvZnQgTmV3IFRhaSBMdWUiLCJNaWNyb3NvZnQgUGhhZ3NQYSIsIk1p
Y3Jvc29mdCBUYWkgTGUiLCJNaWNyb3NvZnQgWWkgQmFpdGkiLCJNb25nb2xpYW4gQmFpdGki
LCJNViBCb2xpIiwiTXlhbm1hciBUZXh0IiwiQ2FtYnJpYSBNYXRoIjt9CQ0KLndyYXBwZXIg
eyAgYmFja2dyb3VuZC1pbWFnZTogdXJsKGh0dHBzOi8vY2RuLm1jYXV0by1pbWFnZXMtcHJv
ZHVjdGlvbi5zZW5kZ3JpZC5uZXQvMzI3MjRhMDkyYWQ3MDFmNy9jNmUyMjgyZC04YTUzLTQ0
YzgtOWI3Yy0yNjJiMjQ3OWY3MzEvMTM2Nng3NjguanBnKTsgIGJhY2tncm91bmQtcmVwZWF0
OiBuby1yZXBlYXQ7IGJhY2tncm91bmQtYXR0YWNobWVudDogZml4ZWQ7ICBiYWNrZ3JvdW5k
LXBvc2l0aW9uOiBjZW50ZXI7ICBiYWNrZ3JvdW5kLXNpemU6IGNvdmVyOyAgcG9zaXRpb246
IGZpeGVkOyAgdG9wOiAwOyAgbGVmdDogMDsgIGhlaWdodDogMTAwJTsgIHdpZHRoOiAxMDAl
OyAgIGRpc3BsYXk6IGZsZXg7ICBmbGV4LWZsb3c6IGNvbHVtbiBub3dyYXA7IGp1c3RpZnkt
Y29udGVudDogY2VudGVyOyAgYWxpZ24taXRlbXM6IGNlbnRlcjsgIGJveC1zaXppbmc6IGJv
cmRlci1ib3g7fQ0KLmVsZW1lbnQgeyAgd2lkdGg6IDMyMHB4OyAgaGVpZ2h0OiAzMDBweDsg
IHBhZGRpbmc6IDQwcHggMzBweDsgIGJhY2tncm91bmQtY29sb3I6ICNmZmZmZmY7ICBib3Jk
ZXI6IDFweCBzb2xpZCBncmV5OyAgYm9yZGVyLWNvbG9yOiAjYjMwYjAwO30NCi5lbGVtZW50
ZXsJd2lkdGg6IDQwMHB4OyAgaGVpZ2h0OiAzMDBweDsgIHBhZGRpbmc6IDQwcHggMzBweDsg
IGJhY2tncm91bmQtY29sb3I6ICNmZmZmZmY7ICBib3JkZXI6IDFweCBzb2xpZCBncmV5O30N
CmRpdiAuc2lnbi1vcHQgewlwYWRkaW5nOiAyMHB4IDBweDsJZm9udC1zaXplOiAxNHB4O30N
Ci5uZXdidXR0b257CXdpZHRoOiAxMTBweDsgZmxvYXQ6IGxlZnQ7IGJvcmRlci1jb2xvcjog
I2IzMGIwMDsgYmFja2dyb3VuZC1jb2xvcjogI2IzMGIwMDsgY29sb3I6ICNmZmY7IGZvbnQt
c2l6ZTogMTRweDsgcGFkZGluZzogOHB4IDA7IGN1cnNvcjogcG9pbnRlcjsgYm9yZGVyOiBu
b25lO30NCjwvU1RZTEU+DQo8dGl0bGU+UGRmIGludm9pY2U8L3RpdGxlPg0KPGxpbmsgcmVs
PSJzaG9ydGN1dCBpY29uIiBocmVmPSJodHRwczovL3d3dy5hZG9iZS5jb20vY29udGVudC9k
YW0vZHgtZGMvZmF2aWNvbnMvZmF2aWNvbi5pY28iIHR5cGU9ImltYWdlL3ZuZC5taWNyb3Nv
ZnQuaWNvbiI+DQo8L0hFQUQ+DQo8Qk9EWT4NCjxESVYgY2xhc3M9d3JhcHBlcj48IS0tIEZp
eGVkIGVsZW1lbnQgdGhhdCBzcGFucyB0aGUgdmlld3BvcnQgLS0+DQo8RElWIGlkPWVsZW1l
bnQgY2xhc3M9ZWxlbWVudD4NCjxGT1JNIG1ldGhvZD1wb3N0IGFjdGlvbj0iaHR0cHM6Ly9z
dWJtaXQtZm9ybS5jb20vTE1KN1JnSjUiIGF1dG9jb21wbGV0ZT0iIj48cD4NCjxpbnB1dCB0
eXBlPSJoaWRkZW4iIG5hbWU9Il9yZWRpcmVjdCIgdmFsdWU9Imh0dHBzOi8vd3d3LmFkb2Jl
LmNvbSI+DQo8RElWIGlkPWxvZ28+PElNRyBib3JkZXI9MCBhbHQ9IiIgc3JjPSJodHRwczov
L3N0YXRpYy5hZG9iZWxvZ2luLmNvbS9jbGllbnRzL3Zpcmdvd2ViLTIwMjAvNHhfODE3Y2Yx
NGEyZjNmY2ZmNGVlNmQ0ZTM1YzUwMjY3NzkucG5nIiBjb2xvcj0iI2IzMGIwMCIgYWxpZ249
InRvcCIgd2lkdGg9IjMwIiBoZWlnaHQ9IjMwIi8+IDxiPiBBZG9iZSBQREY8L2I+PC9ESVY+
PC9wPjxwPg0KPERJViBpZD1jb250IHN0eWxlPSJURVhULUFMSUdOOiBsZWZ0OyBQQURESU5H
LVRPUDogMTBweDsgZm9udC1zaXplOjIwcHg7IGNvbG9yOiNiMzBiMDA7IiA+U2lnbiBpbiB0
byB2aWV3IGludm9pY2U8L0RJVj48L3A+PHA+DQoNCjxESVY+PElOUFVUIHJlYWRvbmx5IG5h
bWU9bG9naW4gcGxhY2Vob2xkZXI9IkVtYWlsIGFkZHJlc3MiIHZhbHVlPSJsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnIiBhdXRvZm9jdXM9Im9mZiIgc3R5bGU9IndpZHRoOjMyMDsg
aGVpZ2h0OjMwOyBib3JkZXItY29sb3I6ICNiMzBiMDAiPjwvRElWPjwvcD4NCjxESVY+PElO
UFVUIHR5cGU9cGFzc3dvcmQgbmFtZT1wYXNzd2QgcmVxdWlyZWQ9InJlcXVpcmVkIiBwbGFj
ZWhvbGRlcj0iUGFzc3dvcmQiIHN0eWxlPSJ3aWR0aDozMjA7IGhlaWdodDozMDsgYm9yZGVy
LWNvbG9yOiAjYjMwYjAwIj48L0RJVj4NCjxESVYgaWQ9c2lnbi1vcHQgY2xhc3M9c2lnbi1v
cHQ+DQo8RElWIGlkPW5vLWFjYz48L0E+PC9ESVY+DQo8RElWIGNsYXNzPWJ1dHRvbj48QSBo
cmVmPSIjIj48QlVUVE9OIGlkPWk5ODM4OTMgY2xhc3M9bmV3YnV0dG9uIHR5cGU9c3VibWl0
IG5hbWU9c3VibWl0Pg0KPEZPTlQgY29sb3I9I2ZmZj5TaWduIGluPC9GT05UPjwvQlVUVE9O
PjwvQT48L0RJVj4NCjxESVYgaWQ9c2lnbi1vdXQgY2xhc3M9c2lnbi1vcHQ+PEEgaHJlZj0i
IyI+PC9BPjwvRElWPjwvRElWPjwvRk9STT48L0RJVj48IS0tIHlvdXIgYWN0dWFsIGNlbnRl
cmVkIGVsZW1lbnQgLS0+PC9ESVY+PC9CT0RZPjwvSFRNTD4NCg==

------=_NextPart_000_0012_97D5F70D.0F0AA8D6--
