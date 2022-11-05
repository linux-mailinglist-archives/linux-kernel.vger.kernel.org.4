Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A9461DDA7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiKETP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKETP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:15:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D9CAE6A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 12:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:From:References:To:
        Subject:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W4nBwDBfKDoc0xA2qTBCGH9AJr2QvpstORAqXPpheTU=; b=uHZefliDnm1xm3pzqaRGuR/2RW
        okGT5SNPEhkW2YrWkUQ6VMldmUgUFEIhEenBHvHf0hIPRRGaeu2WeMH8v8AYQhoESbKir1sYFpUyM
        7Rai+lzmtz7jWxAgNMX6pM4ssoxy5Ic764bAghtFMuDzbYSZZeKW6gIPvZ7YFYsZpluWFyq1srHvZ
        K4UXFOuKMIie6aCy96sKRvHxPwQYEJnizR2mq+sJOw8ppUIHho7VnQSVVHUoAFcA/oLj6Dxcs4exo
        yswu91kSyqndswel0KlsjgrX3eIaRRrzC702C65ZQ4r/orniNum8N5n6B3dh6FhNFHg4VupieNIq5
        ue276+0g==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1orOdY-0077cd-IH; Sat, 05 Nov 2022 19:15:24 +0000
Content-Type: multipart/mixed; boundary="------------oeXxCwi1BRuYsW0yo2WDrh5W"
Message-ID: <f597c5c7-4c49-37b7-9134-ef900ebd5244@infradead.org>
Date:   Sat, 5 Nov 2022 12:15:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Kernel oops issued
Content-Language: en-US
To:     Enrico Bandera <enrico.bandera@dronus.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <958955d6415f4782b955612e6854de72VI1PR09MB38226F88153D921E6B4FD9B6E92D9@VI1PR09MB3822.eurprd09.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <958955d6415f4782b955612e6854de72VI1PR09MB38226F88153D921E6B4FD9B6E92D9@VI1PR09MB3822.eurprd09.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------oeXxCwi1BRuYsW0yo2WDrh5W
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi--

On 10/21/22 06:34, Enrico Bandera wrote:
> Hi,
> I'm facing a systematic crash of kernel, whenever 2 instances of gstreamer are launched together.
> Namely, in our system there is a service that runs a camera manager (that uses gstreamer libraries to handle video streaming).
> If another gstreamer pipeline, accessing the same device, is launched the kernel crashes.
> 
> Please find attached the ending session of kernel log (dmesg)
> I've enabled all debug info possible (I guess)
> 
> Thanks in advance
> Enrico

[adding linux-media mailing list & reattaching the kernel log file]


Can you get any more of the kernel log?
What kernel version is this?

There are 3 out-of-tree kernel modules loaded.
  lepton(O) ap1302_new(O) galcore(O)

Can you reproduce the problem without those modules being loaded?
If they are part of the problem, we probably can't help you.



> Enrico Bandera
> Software Engineer
> enrico.bandera@dronus.com
> dronus.com
> t +39 345 295 00 42
> Laboratorio T45 Ed. Q
> Area Science Park
> Basovizza, SS14 km 163,5
> 34149 Trieste - Italy
> 
> Dronus S.p.A. • Sede legale: Basovizza, SS14 KM 163,5 34149 Trieste (TS) • P.IVA 14668071005
> Ai sensi del GDPR 2016/679 si precisa che le informazioni contenute in questo messaggio ed eventuali allegati sono riservate ed a uso esclusivo del destinatario. Qualora il messaggio in parola Le fosse pervenuto per errore, La invitiamo ad eliminarlo senza copiarlo e a non inoltrarlo a terzi, dandocene gentilmente comunicazione. Grazie.
> Pursuant to GDPR 2016/679, you are hereby informed that this message contains confidential information intended only for the use of the addressee. If you are not the addressee, and have received this message by mistake, please delete it and immediately notify us. You may not copy or disseminate this message to anyone. Thank you.
> 
> [https://git.dronus.com/img/logo_firma.jpg]
> Enrico Bandera
> Software Engineer
> enrico.bandera@dronus.com<mailto:enrico.bandera@dronus.com>
> dronus.com<https://www.dronus.it/>
> t +39 345 295 00 42<tel:00393452950042>
> Laboratorio T45 Ed. Q
> Area Science Park
> Basovizza, SS14 km 163,5
> 34149 Trieste - Italy
> 
> 
> Dronus S.p.A. • Sede legale: Basovizza, SS14 KM 163,5 34149 Trieste (TS) • P.IVA 14668071005
> 
> Ai sensi del GDPR 2016/679 si precisa che le informazioni contenute in questo messaggio ed eventuali allegati sono riservate ed a uso esclusivo del destinatario. Qualora il messaggio in parola Le fosse pervenuto per errore, La invitiamo ad eliminarlo senza copiarlo e a non inoltrarlo a terzi, dandocene gentilmente comunicazione. Grazie.
> Pursuant to GDPR 2016/679, you are hereby informed that this message contains confidential information intended only for the use of the addressee. If you are not the addressee, and have received this message by mistake, please delete it and immediately notify us. You may not copy or disseminate this message to anyone. Thank you.

-- 
~Randy
--------------oeXxCwi1BRuYsW0yo2WDrh5W
Content-Type: text/plain; charset=UTF-8; name="kernel-Oops-log.txt"
Content-Disposition: attachment; filename="kernel-Oops-log.txt"
Content-Transfer-Encoding: base64

WyAgIDM3LjEzMDM2NF0gYXAxMzAyIDEtMDAzYzogQ2FsbGVkIGFwMTMwMl9zX2N0cmwgbGlu
ZTogMTM3MSBldmVudC1JRDoweDAwOTgwOTAxLgpbICAgMzcuMTMxNzA4XSBhcDEzMDIgMS0w
MDNjOiB3cml0ZV9yZWdbMHg3MDAyXSA9IDB4QUExMApbICAgMzcuMTMxNzE1XSBhcDEzMDIg
MS0wMDNjOiBDdHJsLT5pZDogVjRMMl9DSURfQ09OVFJBU1QKWyAgIDM3LjEzOTU0Ml0gYXAx
MzAyIDEtMDAzYzogYXAxMzAyX3NldF9tYnVzX2ZtdC4gY29udGV4dD0wClsgICAzNy4xMzk1
NDldIGFwMTMwMiAxLTAwM2M6IFRyeSBNQlVTIEZvcm1hdC4KWyAgIDM3LjEzOTU1NF0gYXAx
MzAyIDEtMDAzYzogRW50ZXJlZCBhcDEzMDJfdHJ5X21idXNfZm10X2xvY2tlZCBsaW5lIDgw
OC4KWyAgIDM3LjE0MDMzN10gYXAxMzAyIDEtMDAzYzogd3JpdGVfcmVnWzB4MjAwMF0gPSAw
eDA3ODAKWyAgIDM3LjE0MTQ4OF0gYXAxMzAyIDEtMDAzYzogd3JpdGVfcmVnWzB4MjAwMl0g
PSAweDA0MzgKWyAgIDM3LjE0MjcwMl0gYXAxMzAyIDEtMDAzYzogd3JpdGVfcmVnWzB4MjAy
MF0gPSAweDNDMDAKWyAgIDM3LjE0NjI1MV0gYXAxMzAyIDEtMDAzYzogYXAxMzAyX3NldF9t
YnVzX2ZtdC4gY29udGV4dD0wClsgICAzNy4xNDYyNThdIGFwMTMwMiAxLTAwM2M6IFRyeSBN
QlVTIEZvcm1hdC4KWyAgIDM3LjE0NjI2Ml0gYXAxMzAyIDEtMDAzYzogRW50ZXJlZCBhcDEz
MDJfdHJ5X21idXNfZm10X2xvY2tlZCBsaW5lIDgwOC4KWyAgIDM3LjE0NzA1Nl0gYXAxMzAy
IDEtMDAzYzogd3JpdGVfcmVnWzB4MjAwMF0gPSAweDA3ODAKWyAgIDM3LjE0ODIxN10gYXAx
MzAyIDEtMDAzYzogd3JpdGVfcmVnWzB4MjAwMl0gPSAweDA0MzgKWyAgIDM3LjE0OTM3OV0g
YXAxMzAyIDEtMDAzYzogd3JpdGVfcmVnWzB4MjAyMF0gPSAweDNDMDAKWyAgIDM3LjE1OTE0
MF0gZ2V0IDQgYnVmZmVycywgZWFjaCBob2xkaW5nIDk4NDAgYnl0ZXMuClsgICAzNy4xNjY2
NzNdIGFwMTMwMiAxLTAwM2M6IHdyaXRlX3JlZ1sweDIwMzBdID0gMHgwMDFDClsgICAzOC42
ODk4MTZdIFZTWU5DIDE2NSBtaXNzIQpbICAgMzguNzE0NzI5XSBMb3N0IGZyYW1lIHN5bmMh
ClsgIDI0MC4wNjEyMThdIFZTWU5DIDIxMzY5IG1pc3MhClsgIDI0MC4wODYxMjldIExvc3Qg
ZnJhbWUgc3luYyEKWyAxMDMxLjY3MjQwMF0gdmlkZW9kZXY6IHY0bDJfb3BlbjogdmlkZW8w
OiBvcGVuICgwKQpbIDEwMzEuNjcyNDEwXSB2aWRlbzA6IFZJRElPQ19RVUVSWUNBUDogZHJp
dmVyPW14NnMtY3NpLCBjYXJkPWkuTVg2U19DU0ksIGJ1cz1wbGF0Zm9ybTozMmUyMDAwMC5j
c2kxX2JyaWRnZSwgdmVyc2lvbj0weDAwMDUwNDRhLCBjYXBhYmlsaXRpZXM9MHg4NDIwMDAw
MSwgZGV2aWNlX2NhcHM9MHgwNDIwMDAwMQpbIDEwMzEuNjcyNDM0XSB2aWRlb2RldjogdjRs
Ml9yZWxlYXNlOiB2aWRlbzA6IHJlbGVhc2UKWyAxMDMxLjc4MTAwMF0gdmlkZW9kZXY6IHY0
bDJfb3BlbjogdmlkZW8wOiBvcGVuICgwKQpbIDEwMzEuNzgxMDExXSB2aWRlbzA6IFZJRElP
Q19RVUVSWUNBUDogZHJpdmVyPW14NnMtY3NpLCBjYXJkPWkuTVg2U19DU0ksIGJ1cz1wbGF0
Zm9ybTozMmUyMDAwMC5jc2kxX2JyaWRnZSwgdmVyc2lvbj0weDAwMDUwNDRhLCBjYXBhYmls
aXRpZXM9MHg4NDIwMDAwMSwgZGV2aWNlX2NhcHM9MHgwNDIwMDAwMQpbIDEwMzEuNzgxMDQ2
XSB2aWRlb2RldjogdjRsMl9yZWxlYXNlOiB2aWRlbzA6IHJlbGVhc2UKWyAxMDMxLjgxMDMz
MV0gdmlkZW9kZXY6IHY0bDJfb3BlbjogdmlkZW8wOiBvcGVuICgwKQpbIDEwMzEuODEwMzQ0
XSB2aWRlbzA6IFZJRElPQ19RVUVSWUNBUDogZHJpdmVyPW14NnMtY3NpLCBjYXJkPWkuTVg2
U19DU0ksIGJ1cz1wbGF0Zm9ybTozMmUyMDAwMC5jc2kxX2JyaWRnZSwgdmVyc2lvbj0weDAw
MDUwNDRhLCBjYXBhYmlsaXRpZXM9MHg4NDIwMDAwMSwgZGV2aWNlX2NhcHM9MHgwNDIwMDAw
MQpbIDEwMzEuODEwMzc3XSB2aWRlbzA6IFZJRElPQ19FTlVNSU5QVVQ6IGluZGV4PTAsIG5h
bWU9Q2FtZXJhLCB0eXBlPTIsIGF1ZGlvc2V0PTB4MCwgdHVuZXI9MCwgc3RkPTB4MDAwMDAw
MDAsIHN0YXR1cz0weDAsIGNhcGFiaWxpdGllcz0weDAKWyAxMDMxLjgxMDQzN10gdmlkZW8w
OiBWSURJT0NfRU5VTUlOUFVUOiBlcnJvciAtMjI6IGluZGV4PTEsIG5hbWU9LCB0eXBlPTAs
IGF1ZGlvc2V0PTB4MCwgdHVuZXI9MCwgc3RkPTB4MDAwMDAwMDAsIHN0YXR1cz0weDAsIGNh
cGFiaWxpdGllcz0weDQKWyAxMDMxLjgxMDQ0Nl0gdmlkZW8wOiBWSURJT0NfRU5VTVNURDog
ZXJyb3IgLTYxOiBpbmRleD0wLCBpZD0weDAsIG5hbWU9LCBmcHM9MC8wLCBmcmFtZWxpbmVz
PTAKWyAxMDMxLjgxMDQ2Ml0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVl
c3QgYXQgdmlydHVhbCBhZGRyZXNzIGZmZmY4MDAwMTBjM2M4ODAKWyAxMDMxLjgxMDQ2M10g
TWVtIGFib3J0IGluZm86ClsgMTAzMS44MTA0NjVdICAgRVNSID0gMHg5NjAwMDA0NwpbIDEw
MzEuODEwNDY3XSAgIEVDID0gMHgyNTogREFCVCAoY3VycmVudCBFTCksIElMID0gMzIgYml0
cwpbIDEwMzEuODEwNDY4XSAgIFNFVCA9IDAsIEZuViA9IDAKWyAxMDMxLjgxMDQ3MF0gICBF
QSA9IDAsIFMxUFRXID0gMApbIDEwMzEuODEwNDcxXSBEYXRhIGFib3J0IGluZm86ClsgMTAz
MS44MTA0NzJdICAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDA0NwpbIDEwMzEuODEwNDc0XSAg
IENNID0gMCwgV25SID0gMQpbIDEwMzEuODEwNDc3XSBzd2FwcGVyIHBndGFibGU6IDRrIHBh
Z2VzLCA0OC1iaXQgVkFzLCBwZ2RwPTAwMDAwMDAwNDBmYzAwMDAKWyAxMDMxLjgxMDQ3OF0g
W2ZmZmY4MDAwMTBjM2M4ODBdIHBnZD0wMDAwMDAwMGJmZmZmMDAzLCBwdWQ9MDAwMDAwMDBi
ZmZmZTAwMywgcG1kPTAwMDAwMDAwYmZmZmEwMDMsIHB0ZT0wMDAwMDAwMDAwMDAwMDAwClsg
MTAzMS44MTA0ODVdIEludGVybmFsIGVycm9yOiBPb3BzOiA5NjAwMDA0NyBbIzFdIFBSRUVN
UFQgU01QClsgMTAzMS44MTYwNjRdIE1vZHVsZXMgbGlua2VkIGluOiBoeDI4MGVuYyBicmNt
Zm1hYyBjZmc4MDIxMSBicmNtdXRpbCBsZXB0b24oTykgY2lfaGRyY19pbXggY2lfaGRyYyBl
aGNpX2hjZCB1bHBpIHVkY19jb3JlIHJvbGVzIHVzYmNvcmUgdXNibWlzY19pbXggcGh5X2dl
bmVyaWMgYXAxMzAyX25ldyhPKSBzcGlfaW14IGlteF9zZG1hIGhhbnRyb2RlY184NDVzIGdh
bGNvcmUoTykgW2xhc3QgdW5sb2FkZWQ6IGh4MjgwZW5jXQpbIDEwMzEuODM3Mzc2XSBDUFU6
IDIgUElEOiA2OTkgQ29tbTogZ3N0LWxhdW5jaC0xLjAgVGFpbnRlZDogRyAgICAgICAgICAg
TyAgICAgIDUuNC43NC1pbXg4bW0rZzk4Y2E1NjlmYWZjYiAjMQpbIDEwMzEuODQ3MTExXSBI
YXJkd2FyZSBuYW1lOiBWYXJpc2NpdGUgREFSVC1NWDhNLU1JTkkgKERUKQpbIDEwMzEuODUy
NDIxXSBwc3RhdGU6IDYwMDAwMDA1IChuWkN2IGRhaWYgLVBBTiAtVUFPKQpbIDEwMzEuODU3
MjE1XSBwYyA6IG9zcV9sb2NrKzB4ODAvMHgxYzAKWyAxMDMxLjg2MDc5MF0gbHIgOiBfX211
dGV4X2xvY2suaXNyYS4wKzB4N2MvMHg1YjgKWyAxMDMxLjg2NTMxNl0gc3AgOiBmZmZmODAw
MDFiMmEzOTMwClsgMTAzMS44Njg2MjhdIHgyOTogZmZmZjgwMDAxYjJhMzkzMCB4Mjg6IGZm
ZmYwMDAwN2QxMTYyMDAgClsgMTAzMS44NzM5MzddIHgyNzogMDAwMDAwMDAwMDAwMDAxZiB4
MjY6IDAwMDAwMDAwMDAwMDAwMDAgClsgMTAzMS44NzkyNDZdIHgyNTogZmZmZjgwMDAxYjJh
M2NkOCB4MjQ6IGZmZmYwMDAwN2NhZDE0MDggClsgMTAzMS44ODQ1NTRdIHgyMzogMDAwMDAw
MDA4MDAwMDAwMCB4MjI6IDAwMDAwMDAwMDAwMDAwMDIgClsgMTAzMS44ODk4NjNdIHgyMTog
ZmZmZjAwMDA3NGY5MGQ4MCB4MjA6IGZmZmYwMDAwN2QxMTYyMGMgClsgMTAzMS44OTUxNzFd
IHgxOTogZmZmZjgwMDAxYjJhM2E4MCB4MTg6IDAwMDAwMDAwMDAwMDAwMDAgClsgMTAzMS45
MDA0ODBdIHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMDAwMDAwMDAwMDAwMDAgClsg
MTAzMS45MDU3ODldIHgxNTogMDAwMDAwMDAwMDAwMDAwMCB4MTQ6IDAwMDAwMDAwMDAwMDAw
MDAgClsgMTAzMS45MTEwOThdIHgxMzogMDAwMDAwMDAwMDAwMDAwMCB4MTI6IDAwMDAwMDAw
MDAwMDAwMDAgClsgMTAzMS45MTY0MDddIHgxMTogMDAwMDAwMDAwMDAwMDAwMCB4MTA6IDAw
MDAwMDAwMDAwMDAwMDAgClsgMTAzMS45MjE3MTVdIHg5IDogMDAwMDAwMDAwMDAwMDAwMCB4
OCA6IGZmZmY4MDAwMWIyYTNiNjggClsgMTAzMS45MjcwMjVdIHg3IDogZmZmZjgwMDAxMGMz
MTAxOCB4NiA6IGZmZmYwMDAwNzRmOTBkODAgClsgMTAzMS45MzIzMzNdIHg1IDogZmZmZjAw
MDA3ZDExNjIwYyB4NCA6IGZmZmY4MDAwMTBjM2M4ODAgClsgMTAzMS45Mzc2NDJdIHgzIDog
ZmZmZjAwMDA3ZmJhMjg4MCB4MiA6IDAwMDAwMDAwZmZmZWZmZmYgClsgMTAzMS45NDI5NTJd
IHgxIDogZmZmZjgwMDAxMGMzYzg4MCB4MCA6IDAwMDAwMDAwMDAwMDAwMDAgClsgMTAzMS45
NDgyNjFdIENhbGwgdHJhY2U6ClsgMTAzMS45NTA3MDddICBvc3FfbG9jaysweDgwLzB4MWMw
ClsgMTAzMS45NTM5MzJdICBfX211dGV4X2xvY2suaXNyYS4wKzB4N2MvMHg1YjgKWyAxMDMx
Ljk1ODExMl0gIF9fbXV0ZXhfbG9ja19zbG93cGF0aCsweDEwLzB4MTgKWyAxMDMxLjk2MjM3
OF0gIG11dGV4X2xvY2srMHgzNC8weDUwClsgMTAzMS45NjU2OTNdICB2NGwyX3F1ZXJ5X2V4
dF9jdHJsKzB4MzAvMHgyNTgKWyAxMDMxLjk2OTg3Ml0gIHY0bDJfcXVlcnljdHJsKzB4NGMv
MHhlOApbIDEwMzEuOTczNTMyXSAgdjRsX3F1ZXJ5Y3RybCsweDgwLzB4OTgKWyAxMDMxLjk3
NzEwNF0gIF9fdmlkZW9fZG9faW9jdGwrMHgxN2MvMHgzZTAKWyAxMDMxLjk4MTExMl0gIHZp
ZGVvX3VzZXJjb3B5KzB4MTg0LzB4NWMwClsgMTAzMS45ODQ5NDZdICB2aWRlb19pb2N0bDIr
MHgxNC8weDIwClsgMTAzMS45ODg0MzNdICB2NGwyX2lvY3RsKzB4M2MvMHg1OApbIDEwMzEu
OTkxNzQ2XSAgZG9fdmZzX2lvY3RsKzB4OTY0LzB4YjQ4ClsgMTAzMS45OTU0MDZdICBrc3lz
X2lvY3RsKzB4NDQvMHg5MApbIDEwMzEuOTk4NzE3XSAgX19hcm02NF9zeXNfaW9jdGwrMHgx
Yy8weGI4ClsgMTAzMi4wMDI2MzldICBlbDBfc3ZjX2NvbW1vbi5jb25zdHByb3AuMCsweDY4
LzB4MTYwClsgMTAzMi4wMDc0MjddICBlbDBfc3ZjX2hhbmRsZXIrMHgyMC8weDgwClsgMTAz
Mi4wMTExNzNdICBlbDBfc3ZjKzB4OC8weDIwNApbIDEwMzIuMDE0MjI4XSBDb2RlOiBmODYy
ZDgwMCA4YjAwMDAyNCBmOTAwMDQ2NCBkNTAzM2FiZiAoZjgyMDY4MjMpIApbIDEwMzIuMDIw
MzIwXSAtLS1bIGVuZCB0cmFjZSBhMDAxY2QwNzgzYzJhZWU5IF0tLS0KWyAxMDMyLjAyNTAy
OV0gbm90ZTogZ3N0LWxhdW5jaC0xLjBbNjk5XSBleGl0ZWQgd2l0aCBwcmVlbXB0X2NvdW50
IDEKWyAxMDMyLjAzMTYwN10gVlNZTkMgd2FybmluZyEKWyAxMDMyLjA0MTEwMF0gVlNZTkMg
MTA0NzYyIG1pc3MhClsgMTAzMi4wNDU2OTFdIExvc3QgZnJhbWUgc3luYyEKCg==

--------------oeXxCwi1BRuYsW0yo2WDrh5W--
